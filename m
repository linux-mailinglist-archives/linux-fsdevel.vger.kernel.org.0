Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6B3B3F61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 10:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFYIgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 04:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhFYIgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:36:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0351BC061760;
        Fri, 25 Jun 2021 01:33:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso6912340pjx.1;
        Fri, 25 Jun 2021 01:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JaY7zVz/oKhuTLPKCSt7gRnQkLzU56WFHciU+6X4WTE=;
        b=POlL1DIViWz87oeDaDOKhmC972FWo93hj/f61trqz7pE7fzhdQTHtpJ34yDttnakBO
         mhDJ82PTMjkPXOv3GxvtDYtUpPP1Uqb2XWUE2mKQUNtaRSmmB+qc6/qucW0cCX9o2pLk
         7wNlJPCSoTcqhFl+mzgCA6ISabEG/OfaCKj8Ez+6sr7bRk4cxIMsBz1C/ox66lIXs/iB
         kmdqoy5DxOpGpobDs76znZFuRmzATYOX4uhonF8Pe0+M+FM/nvgeHIJVUumXd0FT9xFx
         hyIGong9mPPUiPUKcRfNasjzMk6OY5fDP9Z8pbtgO1truZXNr7eVKNlnrtNa3qO2jZTp
         ZUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JaY7zVz/oKhuTLPKCSt7gRnQkLzU56WFHciU+6X4WTE=;
        b=DhJWULxsrBE5oz4QBBOgvfMHZoHhL02mhDrP8RncPNcT/BE/s3rh9pohV8acGPc/q7
         sZU+cBdSTyMS9iRqTIbz4gXkCNhWNnczSakc5Uv8EBSjvZ1tdohErg9Lom7hp/Cra225
         +E2PEjC6ZUFU8TaeXcqQ3fgrTndihkPxTra7TlJiN+Ft1KhIXz8qU4WYW8GmwbRlrh3n
         tVaRjkPo8P5WFU02+CV9ENG3iS/S0TM94a+4hpFUsEQYvsOeZLBZaZg0MSjsUI+MGUBi
         D7sNw/LkjdI2qPt+ZsV1XPK0031jtXa8C40i9ppp/mZTIPmr4hm4ik68G2+aRUTbcMH7
         1Sjg==
X-Gm-Message-State: AOAM5339+HqZ9u3Wk6kDGmcJ3rTeKGdCksCfYx00SkmAfcWnw/zp4m59
        /GCHaJy0tXpyU0EnaUPe4/E=
X-Google-Smtp-Source: ABdhPJy9XrhB8RY6Qr18+sX6rIwZeCdXKKNKDoqBEN7jjKEsdGcivjxFsgwaFCnc83ut7sCZGcSOww==
X-Received: by 2002:a17:90a:ca11:: with SMTP id x17mr10100125pjt.170.1624610033404;
        Fri, 25 Jun 2021 01:33:53 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id y13sm4625999pgp.16.2021.06.25.01.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 01:33:52 -0700 (PDT)
Date:   Fri, 25 Jun 2021 01:30:27 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] exec/binfmt_script: trip zero bytes from the buffer
Message-ID: <YNWUIwtRYX+n9MaO@gmail.com>
References: <20210615162346.16032-1-avagin@gmail.com>
 <877diuq5xb.fsf@disp2133>
 <CANaxB-zVMxxvt8c1XNKfy6-hAUoodxp=ChJpP_Rn5cTD=26p9w@mail.gmail.com>
 <87pmwfggr0.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <87pmwfggr0.fsf@disp2133>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 02:27:47PM -0500, Eric W. Biederman wrote:
> Andrei Vagin <avagin@gmail.com> writes:
> 
> > On Tue, Jun 15, 2021 at 12:33 PM Eric W. Biederman
> > <ebiederm@xmission.com> wrote:
> >>
> >> Andrei Vagin <avagin@gmail.com> writes:
> >>
> >> > Without this fix, if we try to run a script that contains only the
> >> > interpreter line, the interpreter is executed with one extra empty
> >> > argument.
> >> >
> >> > The code is written so that i_end has to be set to the end of valuable
> >> > data in the buffer.
> >>
> >> Out of curiosity how did you spot this change in behavior?
> >
> > gVisor tests started failing with this change:
> > https://github.com/google/gvisor/blob/5e05950c1c520724e2e03963850868befb95efeb/test/syscalls/linux/exec.cc#L307
> >
> > We run these tests on Ubuntu 20.04 and this is the reason why we
> > caught this issue just a few days ago.
> 
> I like where you are going, but starting at the end of the buffer
> there is the potential to skip deliberately embedded '\0' characters.
> 
> While looking at this I realized that your patch should not have
> made a difference but there is a subtle bug in the logic of
> next_non_spacetab, that allowed your code to make it that far.
> 
> Can you test my patch below?
> 
> I think I have simplified the logic enough to prevent bugs from getting
> in.
> 
> Eric
> 
> diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
> index 1b6625e95958..7d204693326c 100644
> --- a/fs/binfmt_script.c
> +++ b/fs/binfmt_script.c
> @@ -26,7 +26,7 @@ static inline const char *next_non_spacetab(const char *first, const char *last)
>  static inline const char *next_terminator(const char *first, const char *last)
>  {
>  	for (; first <= last; first++)
> -		if (spacetab(*first) || !*first)
> +		if (spacetab(*first))
>  			return first;
>  	return NULL;
>  }
> @@ -44,9 +44,9 @@ static int load_script(struct linux_binprm *bprm)
>  	/*
>  	 * This section handles parsing the #! line into separate
>  	 * interpreter path and argument strings. We must be careful
> -	 * because bprm->buf is not yet guaranteed to be NUL-terminated
> -	 * (though the buffer will have trailing NUL padding when the
> -	 * file size was smaller than the buffer size).
> +	 * because bprm->buf is not guaranteed to be NUL-terminated
> +	 * (the buffer will have trailing NUL padding when the file
> +	 * size was smaller than the buffer size).
>  	 *
>  	 * We do not want to exec a truncated interpreter path, so either
>  	 * we find a newline (which indicates nothing is truncated), or
> @@ -57,33 +57,37 @@ static int load_script(struct linux_binprm *bprm)
>  	 */
>  	buf_end = bprm->buf + sizeof(bprm->buf) - 1;
>  	i_end = strnchr(bprm->buf, sizeof(bprm->buf), '\n');
> -	if (!i_end) {
> -		i_end = next_non_spacetab(bprm->buf + 2, buf_end);
> -		if (!i_end)
> -			return -ENOEXEC; /* Entire buf is spaces/tabs */
> -		/*
> -		 * If there is no later space/tab/NUL we must assume the
> -		 * interpreter path is truncated.
> -		 */
> -		if (!next_terminator(i_end, buf_end))
> -			return -ENOEXEC;
> -		i_end = buf_end;
> +	if (i_end) {
> +		/* Hide the trailing newline */
> +		i_end = i_end - 1;

Your patch changes the meaning of i_end. Now it points to the last
symbol, but this function contains the line:
	*((char *)i_end) = '\0';

and it drops the last meaningful symbol. With the following tiny fix, my
test passes:


@@ -114,7 +115,7 @@ static int load_script(struct linux_binprm *bprm)
        if (retval < 0)
                return retval;
        bprm->argc++;
-       *((char *)i_end) = '\0';
+       *((char *)(i_end + 1)) = '\0';
        if (i_arg) {
                *((char *)i_sep) = '\0';
                retval = copy_string_kernel(i_arg, bprm);

Thanks,
Andrei
