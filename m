Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460634A745B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 16:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345381AbiBBPNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 10:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345460AbiBBPNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:13:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC0EC061748;
        Wed,  2 Feb 2022 07:13:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m14so38733541wrg.12;
        Wed, 02 Feb 2022 07:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BKIYOgXf5K4p+GGgd7bYl/PT9+/8mk3LDQ6uvOqdAPQ=;
        b=q24wxtDg1Lcpl/X9SUx1BRm7NJXN+PWquOa3p+uAr9iubItg/s5Ykr/V1KU6qmBo+e
         IzwrM9WFixv/SDWs0I6aw8Yef9mIfh5X2orRJgqax7ThEcKjM4MJ1qZV0P5j/6Z+qM4g
         mSRkqTWlBqKmH15192c59yK4a9QuNLSKdmIjl8hdhDu0Smc+OyAgvUbNwUk1wlHykNjv
         WX/SPiKncYps/GVKZJnsia10vd3SN7rOgOkG0xwz7OX0mkmxAwdtWcFyFyaDMCoWdwqg
         9R1VSBwMLpr/QQFz5l5ztOGCzqG9JbOvOebztCcx0JS9SQHpkC8cnmae4iyQdqMwin9j
         25GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BKIYOgXf5K4p+GGgd7bYl/PT9+/8mk3LDQ6uvOqdAPQ=;
        b=hNyyvX2IlcUWF/o3QkgPqPS6iL5jDbScfpyv+4+9Q+72MZoclE5GRVFY/rJQk8krrB
         qO/xQA5wOchFmU9fApbbHiF2UQ5pNgkBp2AGMdjscCA4eG5yP6q6g+lb5/dC+RRAiFfG
         sTmP/ui+p/Dk47q9LsFgzMf5WNxokL/16MbUiA9fN1twsWEAD7lamyla5UxqXWPH0Qzw
         hjzFBw4TAed0N5hFws40BFveHK6+sDy9hQCm3PYP086Fl/tU0qrlxBhQpcEHGbztjdMB
         Q+c0BZSfU95MdRPtJRRuSIqg1/qXn+tnlPomk46FtM3qGoj1wU6RM4JyBIDDqF5jBFIx
         9dFg==
X-Gm-Message-State: AOAM531FW02MEP49xpQzy8SNX4UibZYhvCpa5OZ/4o6h3HqGxPsX1k8I
        UwKTPJjzIfh9T+d4n0QlJw==
X-Google-Smtp-Source: ABdhPJzS8E1QCUjnW+GYPyzcTkdscJyLDrLr0/jk9roni0RReInLh+RHrLsFLlBBWGeqEq61AGP5zA==
X-Received: by 2002:adf:f344:: with SMTP id e4mr26779144wrp.362.1643814821893;
        Wed, 02 Feb 2022 07:13:41 -0800 (PST)
Received: from localhost.localdomain ([46.53.252.48])
        by smtp.gmail.com with ESMTPSA id m187sm4905052wme.25.2022.02.02.07.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 07:13:41 -0800 (PST)
Date:   Wed, 2 Feb 2022 18:13:39 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests/exec: Avoid future NULL argv execve warning
Message-ID: <Yfqfo0rbq/B/l6IP@localhost.localdomain>
References: <20220201000807.2453486-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220201000807.2453486-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 04:08:07PM -0800, Kees Cook wrote:
> Build actual argv for launching recursion test to avoid future warning
> about using an empty argv in execve().

> --- a/tools/testing/selftests/exec/recursion-depth.c
> +++ b/tools/testing/selftests/exec/recursion-depth.c
> @@ -24,8 +24,14 @@
>  #include <sys/mount.h>
>  #include <unistd.h>
>  
> +#define FILENAME "/tmp/1"
> +#define HASHBANG "#!" FILENAME "\n"
> +
>  int main(void)
>  {
> +	char * const argv[] = { FILENAME, NULL };
> +	int rv;

Can we move out of -Wdeclaration-after-statement mentality in tests at least?

> -	int rv = execve(FILENAME, NULL, NULL);
> +	rv = execve(FILENAME, argv, NULL);

	int rv = execve(FILENAME, (char*[]){FILENAME, NULL}, NULL);

is cleaner (and modern)!

>  	if (rv == -1 && errno == ELOOP) {
>  		return 0;
>  	}
