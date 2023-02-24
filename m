Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09736A2453
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 23:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBXWgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 17:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBXWgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:36:32 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A87D1B2D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 14:36:31 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-53865bdc1b1so12146077b3.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 14:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcPGn+M6rIqx4tq8u4y5PnmVvUlM4XopORLae9pnp88=;
        b=QOKHFuzxD9Oty0a5Re3OcanrsUmjZ7YVrnvH6W2tuNQqBHXx+lQ3dG9qCPTRT0a+KN
         muI7pzifbe+Ya0/9S758YpqEubAIaILij0y/Yq6KSLuehY72U9iN2uC5eww/27YnHOwm
         7tT20/kgLULJFJO8cQqXDbuebovMxSKrMRNPoA1xisQygA71xz3/LuNX0FqUVFYi5sPl
         xTalxKiPHjmh+Le2ki3dJpFRoW8fewbUcfT4XSY/Iez8ee8FfAehpbz/raDXqdiTXAos
         YLdFzMOIW6Ir9rLt6BX0gsge+6jtZ75hVk3ZZEQ5IRZtYCw1ZRwcYo+1GdGCQ/t8rBcR
         VW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcPGn+M6rIqx4tq8u4y5PnmVvUlM4XopORLae9pnp88=;
        b=j6+W32n8zmrmqhfsVWoqBzY9K+xZBcFhMOUjKOmiX6sn88ZGCDzBiv8XFjymm5AHjl
         ihp5V+uP+fu4KkT8lDWOQiQTms7y9IjpCP+4ImbAW6pCalWdED+EP8YqQu+wUytQ0+oL
         g4SAS4Xdt6+4/fYOJQLNwpU35qEGMcu0WLXNQrwpVc89GHwwJdcAWOixfVrzTnSGbp5a
         uitE75ds54+u7kiukLd1+6ecEjWEcKKaty2h1wsnOZTx2rTRt24nkpFOvKngBhYfKQ5f
         bl+TKbAQvgAtBUPmfZ+gj1/F6SKjEzSEGepQtwCmuFRBZ52cw3UTjFelcA700+HBqB6l
         fPPw==
X-Gm-Message-State: AO0yUKXnbUNcfAxSUiYPXtl5BXkRlWScF0JSIdZI1+z0+5lszaY6yfG0
        pC8BI1gQH/NAhGT6fsEu8i5DsjJ42+w=
X-Google-Smtp-Source: AK7set9L2FIpwGMGECLyskWfXlzU0H7sjRSGI9vrEuoVRE3jOXUP1tVhvhXXfg/VsQ8P5PxI02LV4EYJTec=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:b35d:3867:2eb8:33e4])
 (user=drosen job=sendgmr) by 2002:a5b:301:0:b0:a09:32fb:bd6c with SMTP id
 j1-20020a5b0301000000b00a0932fbbd6cmr4015876ybp.7.1677278190733; Fri, 24 Feb
 2023 14:36:30 -0800 (PST)
Date:   Fri, 24 Feb 2023 14:36:26 -0800
In-Reply-To: <20220622194603.102655-1-krisman@collabora.com>
Mime-Version: 1.0
References: <20220622194603.102655-1-krisman@collabora.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230224223626.565126-1-drosen@google.com>
Subject: Re: [PATCH 0/7] Support negative dentries on case-insensitive directories
From:   Daniel Rosenberg <drosen@google.com>
To:     krisman@collabora.com
Cc:     ebiggers@kernel.org, jaegeuk@kernel.org, kernel@collabora.com,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These look good to me. It will be nice to have negative dentries back for
casefolded directories.

-Daniel Rosenberg
