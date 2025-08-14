Return-Path: <linux-fsdevel+bounces-57864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CFCB26061
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 11:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B219D7A54A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 09:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE502EBDC5;
	Thu, 14 Aug 2025 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="evPrOPwa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0872EB5D3
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162708; cv=none; b=m8yJHXhHbQZgEK9f1fZO4GzeT5saA35LilYz1ibhU+6a7vfsIfZPwKxH7o+bWRHmzv4E1IlAun4CAvtPLndnPEMMy97byuoOOqv1jbKEN5QBc/TG46IbuzMZU8CJLCauMAMOow1Gc5PgRcxxv7BT3JjD/XHbJfdAihDDQsZPUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162708; c=relaxed/simple;
	bh=6ur2FiPRAsr04qJACCKeVFD8APZaXxyHJ75mGWyye5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJslGgvCXTXTAE215kXl0MRFl9+G2Aab+bvshko73ftzyKNMqvkKsIb0VBuCT5/rl/kde/HbVuU96HIKRvIPA2dY9MYNbyL2pYcVk1zE52FcNTMweh+SN6emN5Nl/4y89bdPZohxKUuvCcwk+r7dwmMvN5TJRJD7YKbXLvWm04Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=evPrOPwa; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109bd8b09so9335481cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 02:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755162704; x=1755767504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XEou2PxH/gWML+WGi/agRIgZ1Bm4LQKTMmy4cp+tAB0=;
        b=evPrOPwa0i8D6BrR2aptjHqBddbuW1viY78qhOx5Kx1LjkpmioP9p2+0aOvZ69G8wm
         Swh5mDPEDGFaHjtuZZoqgbstlADjCYsM+hYsv5K14mWa+rC003UIZDoJaWTEJqBdAI6p
         hvNk/567K8zz1bthwOpAXE8g7bVazOxkxARFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162704; x=1755767504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEou2PxH/gWML+WGi/agRIgZ1Bm4LQKTMmy4cp+tAB0=;
        b=im6TClZg82aUUPNjuE7EYC9mx5ZT7yJOCLp59Dnl5Gd7a4a3si9E4GMgdGloFB3K7b
         GKi1eawEJf/X7v726or4fwmlHw/0lrrFWzDID++KvCfZWpBadjoV9z0aaAVpTdHfaxJF
         aFgzjAIcDWZX6k512fmFurPKGsuzd4QA4sQ3LOkxcI1OO1Tuh4BhLTiQC/Aaxkt2oIzE
         srwlTJbHHP2olLCZzfLCz5OZNSyAWVbGEDxHyaVh6xbpYO2sc6S5Ka1zMhsGoi2VeNGa
         P5HWSEgq45t3KlCySXws+jvxMiaPIp6DmyZlqT6/Z9FXhkkHHRC9N83AnmZXhw4Xfpzg
         3cIA==
X-Forwarded-Encrypted: i=1; AJvYcCXeahdafLPxSIOq/G9b/4KBAPHw1w4Yq5CHDzlGPzSoYVNDPpUBF+lfekaXTPLbZeeDKq1+dej08rELs3S+@vger.kernel.org
X-Gm-Message-State: AOJu0YyjvbnmYtNC+y9HAoprdutjMLeEoMOsZkASWHkdwYJw1W/Wfx3l
	smrWX+Jj715DrKXSHm0R+9DdhiDL1SyLFRettT5q8U1a3v8qevYGsn6JP2qc/qUzFpA5wG1Nbt8
	rRxEPTnX3Y15TBPsP2j9eupHD9FtlXU32juNYdHqqYw==
X-Gm-Gg: ASbGncvHa2shY93w+9b9gptys+vnmh2WfXfCFbydpzYlfQ8YWo16/3z9YW8zQWP5xan
	S56cXZi4T01fcEUYUK6KvC3OcQDxijVhzSx2Fq/TKP1qG1Kt0rF6gqjCung6wnc/lEejQx11DAD
	/5OTasSBPKGQuhARpgpBTWcZWHGl51KqjxQtFNPJeVFNYyzxYshkHdabS+zJUXA9yq2Rz51OpSs
	Wa6
X-Google-Smtp-Source: AGHT+IFCLxHqhbW5cYwwM0f6rLXRb2wQ+k9MMBrMAQ3jV8dOhZr9WnM0r34eq3vf8YZWTlzPwlu3SFphppk71Ff7OXU=
X-Received: by 2002:a05:622a:420e:b0:4b0:6836:6efa with SMTP id
 d75a77b69052e-4b10c3fb069mr23963021cf.17.1755162704432; Thu, 14 Aug 2025
 02:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813151107.99856-1-mszeredi@redhat.com> <20250814082444.198-1-luochunsheng@ustc.edu>
In-Reply-To: <20250814082444.198-1-luochunsheng@ustc.edu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 11:11:33 +0200
X-Gm-Features: Ac12FXzUcjM-_JPAZJLlIvSxGIjngfrPRX6BbdsJPIkGPTzJIpPCDyMHDLyb6Pg
Message-ID: <CAJfpegvi15F-ByBsAaR700L9E6UZG=GxVNt-fmE4fW5OpoF25A@mail.gmail.com>
Subject: Re: [PATCH v2] copy_file_range: limit size if in compat mode
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: mszeredi@redhat.com, amir73il@gmail.com, brauner@kernel.org, 
	bschubert@ddn.com, fweimer@redhat.com, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 10:28, Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>
> On Wed, Aug 13, 2025 at 5:11 PM Miklos Szeredi wrote:
> > @@ -1624,8 +1629,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
> >        * to splicing from input file, while file_start_write() is held on
> >        * the output file on a different sb.
> >        */
> > -     ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> > -                            min_t(size_t, len, MAX_RW_COUNT), 0);
> > +     ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out, len, 0);
> >  done:
> >       if (ret > 0) {
> >               fsnotify_access(file_in);
>
> There is no problem with submission, but I have a doubt in the call chain:
> `do_splice_direct -> do_splice_direct_actor:`
> static ssize_t do_splice_direct_actor(struct file *in, loff_t *ppos,
>                                       struct file *out, loff_t *opos,
>                                       size_t len, unsigned int flags,
>                                       splice_direct_actor *actor)
> {
>         struct splice_desc sd = {
>                 .len            = len,  //unsigned int len
>                 .total_len      = len,
>                 ...
>         };
>
> The len member in the struct splice_desc is of type unsigned int.
> The assignment here may cause truncation, but in reality, this len
> won't be used. Can we directly delete it?

Yes, looks safe.  Goes back to commit introducing splice_desc
c66ab6fa705e ("splice: abstract out actor data").

Thanks,
Miklos

