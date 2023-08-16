Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB1C77E19D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 14:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245155AbjHPM2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 08:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245262AbjHPM2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:28:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A7826B5
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 05:27:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9936b3d0286so908669466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 05:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692188867; x=1692793667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aaCcsSxEpyyqDlzbXB5HOjQbGizw0wp80mopcOcdi0M=;
        b=hMjB0UzncaxXwNyO/6mAQIWoL8eI9H/wuORRT+ykfvjKMRGhelkIBJ0FeOAK98QfFj
         6ugSNV9MPsdU+RvWFY3NcLCp8Cwe0cL1PvY/9OnmJm1kU9YIi4/r+79pmkAKx6NngaVj
         I/Qksm5+Ox7lTjTt+d7WbvJ0unewmIt4GL1kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692188867; x=1692793667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaCcsSxEpyyqDlzbXB5HOjQbGizw0wp80mopcOcdi0M=;
        b=N8biVATUzfJ0qjbZnpJncTeco049IBYBOV7BvHkY5vpZO0QqDX8F2JZ0dv9cijZ0ng
         YwOOeU/mjKc2k4Sot+ZbDV05x2MSO8oP0Jv/5SDKJxT8CTLgmioxFQKzstxjYkviOq0E
         zb4YWdLQOkHszHFCagJJbQAiSrqwGhMA2GJP8mcISQz4CmIKQnW1X/IywCcN04/K9u3+
         Z934/W6seNR6MRhbjER1tulw6QXZ0fWnkcKn5DKHWlmEicyiEw92dXvVyQULuWIw46+j
         aCY6glKTbZzdqvnkLi/0shHS0HbyfH5DcRLSAivi+jlIezTjRFQd9nLvnfB/aWw3T8DN
         wBkQ==
X-Gm-Message-State: AOJu0Yw5Ap+pzswPv1swRRgs6oWiDstMeNNDxTDx854S18uAX5OoKnhW
        4a2pFrNvYpvsnWahe6ukw+MY3IvgUFS/Y4SPHhcISQoGvM/H8oxpzcw=
X-Google-Smtp-Source: AGHT+IFEJjQsMHwnxXfKTZ7htXSjeP5q0ZYCuaZN8uFVfqYiUPc7DgSetH5Qj6mp/A267t0Kgo6sMlUQkl9GXMvZHvk=
X-Received: by 2002:a17:906:ae88:b0:99c:6312:73ca with SMTP id
 md8-20020a170906ae8800b0099c631273camr1317797ejb.71.1692188867145; Wed, 16
 Aug 2023 05:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com> <20230711043405.66256-3-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20230711043405.66256-3-zhangjiachen.jaycee@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 16 Aug 2023 14:27:35 +0200
Message-ID: <CAJfpegtVQywX28=H+msmkcjaELpfQr6_UdvNZdCN3_B8KCfYTA@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: invalidate dentry on EEXIST creates or ENOENT deletes
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        me@jcix.top
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Jul 2023 at 06:36, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> The EEXIST errors returned from server are strong sign that a local
> negative dentry should be invalidated. Similarly, The ENOENT errors from
> server can also be a sign of revalidate failure. This commit invalidates
> dentries on EEXIST creates and ENOENT deletes by calling
> fuse_invalidate_entry(), which improves the consistency with no
> performance degradation.

Applied, thanks.

Miklos
