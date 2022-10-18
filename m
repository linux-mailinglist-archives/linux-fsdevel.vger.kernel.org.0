Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D864602599
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 09:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiJRHWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 03:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJRHWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:22:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B5AB823
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 00:22:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r18so12552665pgr.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 00:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmmQqngBHRO64jwJHlH4N8QJ8HHeFfHjYmmW2fvTNrE=;
        b=mKyGm3XbRd8gH9cVGki2o1JHhGdcCBGN+sKVLSvL4QrvYRZrmNHYVkn3fPf6/zZbF8
         3dSuHMcZ+u5twLyXF1CCYNKe93YlLTLAJr+tQ0ddx8gVLJAzLDG/4hzDsZ5jEJNG/4v/
         +BCij7wsdF/uu9G2B0LiZv2OE9AF28ixq1SWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmmQqngBHRO64jwJHlH4N8QJ8HHeFfHjYmmW2fvTNrE=;
        b=wLzZdAhBocVgp/7OD6GaU1wppPRylj3s/COlp/zHyugST+qhSD2ue1nDnPjBaMLjxw
         Wt/xDsvblN4HcdOwD/bPvV5VgA++wHZx4sAlt+WtyLbZzk1R4fEEkAuHqzIpZkJ4sEl6
         XeJy3UJ/6EsLHr673ziAb7PE/VWJLFrjTdNDPNdpUiDiY7aLo1z/xQv0YAnD0OhufyW6
         REJtxtJcPBUtOPnin0pm3znzLMvVTxJUQCA1ovtCHmlns0m5C21A0aNrflBbavjyVE7u
         0BJfuLl6W+V4I+KXQCy0j1g3Hith+nQSLJbA+cBxRpBmYA7Gklp54jooPifqlOdX1S47
         CDNg==
X-Gm-Message-State: ACrzQf2lcRJny99yFnavB42Ijw7kOQLFsLxO/zI6uzYf9X7RO/mAM7w9
        Q0D8ecwhdVAc0BTHo8phd4QlQA==
X-Google-Smtp-Source: AMsMyM7sSHggHqyJ0TcgW9+BkVyaT7rEgzYrT/GyJ+YeoRMLr8q0Oj65cetn/KVqd9ihtHbeu0I/ww==
X-Received: by 2002:a05:6a00:13a3:b0:563:6d36:ba58 with SMTP id t35-20020a056a0013a300b005636d36ba58mr1576650pfg.43.1666077742371;
        Tue, 18 Oct 2022 00:22:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709027e8800b00178af82a000sm7864182pla.122.2022.10.18.00.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 00:22:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, ebiederm@xmission.com,
        bernd.edlinger@hotmail.de
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] exec: Copy oldsighand->action under spin-lock
Date:   Tue, 18 Oct 2022 00:22:06 -0700
Message-Id: <166607772207.3775126.2855869252440923728.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <AM8PR10MB470871DEBD1DED081F9CC391E4389@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
References: <AM8PR10MB470871DEBD1DED081F9CC391E4389@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 7 Jun 2021 15:54:27 +0200, Bernd Edlinger wrote:
> unshare_sighand should only access oldsighand->action
> while holding oldsighand->siglock, to make sure that
> newsighand->action is in a consistent state.

Applied to for-next/execve, thanks!

[1/1] exec: Copy oldsighand->action under spin-lock
      https://git.kernel.org/kees/c/f53283b0165f

-- 
Kees Cook

