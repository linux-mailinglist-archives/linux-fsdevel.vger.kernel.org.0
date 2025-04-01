Return-Path: <linux-fsdevel+bounces-45440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AB9A77A94
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95FE57A2086
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C83202F65;
	Tue,  1 Apr 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW1ZtoxY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE2202C4A;
	Tue,  1 Apr 2025 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509846; cv=none; b=HHlXuA6PSVWpZnqBy6Lksth08AvUvmoyAx1UJcR4v8b2l+2HG9xWYOht0Bo80QWH/aAV6riNNFkzzO0vRpTpJZlyHhgGx8oEfODokFzBo9BSvwQdzLQ7JHS4cAdeVTmuHWouPBSldfSIC7Beb7R7sZ1TMLekx2jsRQ6FzQg7EYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509846; c=relaxed/simple;
	bh=R6wjMoC006mfuBMJ9Wu3kttQzt3UeU7MYbAJy7wWNhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AazrqQnVQVGvhiRQVmdRR/r9MtoyPuZVe3X3x12eG93FbxtEVfr5hV3l/uDJatvbl8gYhgiumKtPM6W0AG6IgbPRfXEis/4PB+GWAbDK4n59iJKpJhxb3nRPC4+Y09Ra9pDvoY+b3Z1QIaxRTSRDpbXxmR/7/+1/UTc6lLHi/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW1ZtoxY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac25d2b2354so890031766b.1;
        Tue, 01 Apr 2025 05:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743509843; x=1744114643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6wjMoC006mfuBMJ9Wu3kttQzt3UeU7MYbAJy7wWNhU=;
        b=DW1ZtoxY1Et/qmjk59qDcyihcc3dOKVmWJ9AmezshYaFx8OcbeDLCePOWJ905HmI3n
         1m9syvP4NEpbetKL5ArnllfVx2TQqhv1zRsY8tSbu2f+dbSU7D3G2mhc2ERqGrxwn0LH
         WhhWA88zoiWXzmVVjF7fhPt+RZ0VGCe6XJkyQLoC9b2Rj5AalzvMzFa4XMmzNocJ3f8o
         CRwbwM2bXZQMxjnq+v4u69KemCI+FOdOzq4tyY+YDOzOfOCN6OV5nrzGDjozfmjL+SxD
         6Xpvyi6Z9nmpzz4XbHWzSZuTy2RsfJUS/UTeJbReDXLu+8Uj0RHAn9rCHnFUsGIpOBH6
         XDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743509843; x=1744114643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6wjMoC006mfuBMJ9Wu3kttQzt3UeU7MYbAJy7wWNhU=;
        b=S6FhxzVhNvNWP0FzuNCaiUjwMChPro7xi6HcpwfWsKE1rriR9K9FIf1xYTOm3Aok6L
         ZeEflw2OiiM1RkzzJkLbbUicPtCfAdxuVxy96xGBfvqV20yotaA6tO10cT0cLg+ZplaV
         2bXIxm0OY5I+jAmRruc4gPz6d6ayqb8tNZm2yOzMEYBzR9GL8qthNsypNSKvbNVW6uJM
         ivV8oinv75Kz6wldsc9gJWbwEdawfIwbRKjkoGXjcOU3vAYYXNcECP+r6q2nkjxcUFVm
         hBS231Z6O4OcI86zdyFvQPWR2macOgjw3hZ073mAFN4derjTpCADoYz52KjQYT3dNbEU
         E0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUijELK4Ooeo6Jh4BIVKaWhQlxg4BUy5ILNdOj5XEfaeDv9QTX7BsCkeBO4tIc36dkAbunmIxObs7k2x+iE@vger.kernel.org, AJvYcCW+TcI4ChBjfsTzivrrlpflTlB7LeFB4ao/f0PjlWEskjx78A3620tccmLsMl9SksbEqqq0q6GhI2317BrK@vger.kernel.org
X-Gm-Message-State: AOJu0YwAfVw1W1cCFqCM12UxEvsZc+iX0dgFMijOAOjm1OUmueeVDHl/
	4BO3BIaVDT4WBEKPolK/9lyJAtvMGqvKMXoEmJrE/zTUs5UhSGSv4MlH0zwK17EpHhFGBzbaqcN
	zxURiNEsQud4VcXP3IURmP/+Vcyg=
X-Gm-Gg: ASbGncuZIyONwnx8PppfxkVg9IO8rKP7gUqKuNRJQFbX2PJ24GZH2DNAzfv0sj885eb
	14MmTehAGlE2d/5DERGVKk5FlV48qFYFxnvztLrUODMG3quaqsilnswq/uW3MjzT2MSrtlJIf5U
	RffqwsrgRyLWuilfJbU2MGvN/a
X-Google-Smtp-Source: AGHT+IF1nodvsfxM8zzvgDFfuNGksOlNXTVYSllDNvNWRsSMi6Ek74zuAjP8HfJ3Yu8HUYZTQAkZ4345X0A5wo6Nv+8=
X-Received: by 2002:a17:907:d14:b0:ac2:e748:9f1c with SMTP id
 a640c23a62f3a-ac738a790dfmr1259620566b.33.1743509843295; Tue, 01 Apr 2025
 05:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACVxJT_qZP-AKUzf5sXfp2h+qJ+L0BZit3pgi-aGCuXk4Kmzuw@mail.gmail.com>
In-Reply-To: <CACVxJT_qZP-AKUzf5sXfp2h+qJ+L0BZit3pgi-aGCuXk4Kmzuw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 1 Apr 2025 14:17:10 +0200
X-Gm-Features: AQ5f1JrDVLMvYn_4h4FXTR8U-qtdT8ydaPcZt_-TUhzfgg0KQa9D2bkoc4ZDO3M
Message-ID: <CAGudoHFThX1-VQ9vte4YwtjA6aCNQ0Hc5X-=yxyjdzBjD6Kr-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] proc: add a helper for marking files as permanent by
 external consumers
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Linux Kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 1:14=E2=80=AFPM Alexey Dobriyan <adobriyan@gmail.com=
> wrote:
>
> > +void proc_make_permanent(struct proc_dir_entry *de)
> > +{
> > + pde_make_permanent(de);
> > +}
> > +EXPORT_SYMBOL(proc_make_permanent);
>
> no, no, no, no
>
> this is wrong!
>
> marking should be done in the context of a module!
>
> the reason it is not exported is because the aren't safeguards against
> module misuse
>
> the flag is supposed to be used in case where
> a) PDE itself is never removed and,
> b) all the code supporting is never removed,
> so that locking can be skipped
>
> this it fine to mark /proc/filesystems because kernel controls it
>
> this is fine to mark /proc/aaa if all module does is to write some
> info to it and deletes it during rmmod
>
> but it is not fine to mark /proc/aaa/bbb if "bbb" is created/deleted
> while module is running,
> locking _must_ be done in this case

Well I'm unhappy to begin with, but did not want to do anything
churn-inducing. The above looks like a minimal solution to me.

The pde_ marking things are in an internal header and I did not want
to move them around.

If anything I'm surprised there is no mechanism to get this done (I
assumed there would be a passable flags argument, but got nothing).

What I need here is that /proc/filesystems thing sorted out, as in this cal=
l:
> proc_create_single("filesystems", 0, NULL, filesystems_proc_show);

Would you be ok with adding proc_create_single_permanent() which hides
the logic and is not exported to modules?

--=20
Mateusz Guzik <mjguzik gmail.com>

