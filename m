Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA68203B91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 17:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgFVPwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFVPwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:52:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F2EC061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 08:52:14 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k1so7746555pls.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1jAecUBRNNwg531r2ngQNuJPt9cbBrbCOcwUTtNGxXw=;
        b=W88b8tanBZiJQquVQKTuYSWPRTjwRfh+gjUDyLtXIE14nQutxQjojCO+YmDgq7R5Nd
         pQ9lcUQ7FoYdz4Flv7hx7AlhET+EpSXVYgwwaSeRcH3nnHwt00stVG7oIKTDNGJSigmY
         BcyeWRkfWHPtxTt4Vs8+juKdpVtxyNQtVP1BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1jAecUBRNNwg531r2ngQNuJPt9cbBrbCOcwUTtNGxXw=;
        b=tRbfvP1ZH+0O75/wUvsr7AtKh8mqa/vro+F/jmby+2dbY7OQCfMQBrF4hepbueUXzt
         V55ppZSgOpBJO15yLcJQr9ySddxmXO8HC5TZAZ34fW9yVwCFoB2UCI5Y9i6ODzav4deA
         zgBCRc94NHdikUIzi6/8fLNRrFfHi52cmFJ6mcJGYrbDNcnkkyt4GQSnZzH+h42LmgSy
         FffgFmB2ZO4mU1ZXCygOcs61XkiA5IJPLciA0TQbBvdClFRbHQXmeS4xbT7gFkJfVk8S
         YimE0K4y6//wBTI3xeisdApJjQstVCOExTfIA0DUiZspEg3wo5BG3C1Bg71KmyP1vsFy
         hLMA==
X-Gm-Message-State: AOAM533NI0Y5nYiGvetCuDT4J0MNabw0YZrOT4GfMbJ+9R5KiXr9PQdN
        s9EviQZ8VVuyh9xU4+ZHE1Ldew==
X-Google-Smtp-Source: ABdhPJwdMm7KDMVVPKDlRcBWVqoxYVreqXfiVr7AuIrwhaVn0+M/ZT4LafMuOToqhH+znJUdGlqtIA==
X-Received: by 2002:a17:902:8208:: with SMTP id x8mr19303025pln.114.1592841134205;
        Mon, 22 Jun 2020 08:52:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4sm9383039pgf.9.2020.06.22.08.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:52:13 -0700 (PDT)
Date:   Mon, 22 Jun 2020 08:52:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Kadashev <dkadashev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fs: Expand __fd_install_received() to accept fd
Message-ID: <202006220851.7B817663C7@keescook>
References: <78a2ea3c-1aa5-5601-b299-25aa8d77c758@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a2ea3c-1aa5-5601-b299-25aa8d77c758@canonical.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 04:11:30PM +0100, Colin Ian King wrote:
> Hi,
> 
> static analysis with Coverity has detected a potential issue with the
> following commit:
> 
> commit 8336af9ab8c5d64a309cbf72648054af61548899
> Author: Kees Cook <keescook@chromium.org>
> Date:   Wed Jun 10 08:46:58 2020 -0700
> 
>     fs: Expand __fd_install_received() to accept fd
> 
> Calling __fd_install_received() with fd >= 0 and ufd being non-null will
> cause a put_user of an uninitialized new_fd hence potentially leaking
> data on the stack back to the user.
> 
> static analysis is as follows:
> 
> 1050 int __fd_install_received(int fd, struct file *file, int __user *ufd,
> 1051                          unsigned int o_flags)
> 1052 {
> 1053        struct socket *sock;
> 
>     1. var_decl: Declaring variable new_fd without initializer.
> 
> 1054        int new_fd;
> 1055        int error;
> 1056
> 1057        error = security_file_receive(file);
> 
>     2. Condition error, taking false branch.
> 
> 1058        if (error)
> 1059                return error;
> 1060
> 
>     3. Condition fd < 0, taking false branch.
> 
> 1061        if (fd < 0) {
> 1062                new_fd = get_unused_fd_flags(o_flags);
> 1063                if (new_fd < 0)
> 1064                        return new_fd;
> 1065        }
> 1066
> 
>     4. Condition ufd, taking true branch.
> 1067        if (ufd) {
> 
> CID: Uninitialized scalar variable (UNINIT)5. uninit_use: Using
> uninitialized value new_fd.
> 
> 1068                error = put_user(new_fd, ufd);
> 
> Colin

Eek. Thank you. Fixed with:


diff --git a/fs/file.c b/fs/file.c
index 9568bcfd1f44..c0bcf4c4fb12 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -963,12 +963,14 @@ int __fd_install_received(int fd, struct file *file, int __user *ufd,
 		new_fd = get_unused_fd_flags(o_flags);
 		if (new_fd < 0)
 			return new_fd;
-	}
+	} else
+		new_fd = fd;
 
 	if (ufd) {
 		error = put_user(new_fd, ufd);
 		if (error) {
-			put_unused_fd(new_fd);
+			if (fd < 0)
+				put_unused_fd(new_fd);
 			return error;
 		}
 	}
@@ -976,7 +978,6 @@ int __fd_install_received(int fd, struct file *file, int __user *ufd,
 	if (fd < 0)
 		fd_install(new_fd, get_file(file));
 	else {
-		new_fd = fd;
 		error = replace_fd(new_fd, file, o_flags);
 		if (error)
 			return error;

-- 
Kees Cook
