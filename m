Return-Path: <linux-fsdevel+bounces-71193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A37A7CB8BDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 12:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CA0630562E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 11:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF472D0283;
	Fri, 12 Dec 2025 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOjUUd6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C62877E6
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765539903; cv=none; b=EvNFmPGWnRs2xb1ppfzh/Ce5NIWc6NaSkxOu6dstMp/N+Gl9+sw5X/UZHfagT6lGY0cOLngTWfqTzQSqs2Oqeu96alxUaXKpBBjRXgLa33yrRq8wne+GPS7Rfro/Z9sZEkgmxb8es8bfQDnjpPZmt+XVuciz6GdId6zk7oJHWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765539903; c=relaxed/simple;
	bh=QV83dHXXsBkhiscI9yTpQIJ6O4fN2KeR0ILbU0KVUa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcQKkmCsCrWBBy8khxI2CcDJPmfhP6ArGWcCVgunFS5khc41nEwF8ZL9wsJyFLtxrBW68Zv0istlKlHMXiEsRyTwBlj7KauYkfp+COY5M+faFItz3sjnLl77WTCmAgeQzqtexL18x2rJReET0pcAQ8bCmVbSx3st/XWw/P4hM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOjUUd6j; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-647a3bca834so1641683a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 03:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765539900; x=1766144700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QV83dHXXsBkhiscI9yTpQIJ6O4fN2KeR0ILbU0KVUa8=;
        b=DOjUUd6jjmBMERovmTQ8kJnNB2sLF0ZR0k4bKOFymqKXBmaK6WxURzrrM6KhnP5B+6
         56TRSY2mNBeZXR2/WILe0wyNwTda7x3WUaEdTkW1xVecfHFdGEiHgDxRbEFbxcVvEg0V
         8sGMu4LsRRcMPbCfovtblSBT6AcIYVFNFpQn0EixEu9PjazC9gP3amftMRN7M1UzU9Kj
         CFstPxSfIvCHAptm6T1KU6I2LHIGwWQJpJAz8MEQOFGSrVSAQYYjhswbhaDZPJs7umlm
         J9se7XPvtZjFyv3wcSiU7zyL8hb5HUDvBsIL+zzv6wKqsran214+kP1B0jCddVULh/K7
         JxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765539900; x=1766144700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QV83dHXXsBkhiscI9yTpQIJ6O4fN2KeR0ILbU0KVUa8=;
        b=aBOFaOEUCEjHJy8osyX18jys3Tg94kGgkYpWCfzunYihx+UgPt9sJgce2yTG1g1lMb
         acHzepO8OKuspFVaEqETlhJemHxiFb7UW6EFhPHdUJAh1d9FpCtapDJ32smetfeiJnRb
         hGn5PuHwKn8TXrRdUIKquzDuJWtha47YHLFVLvVsTZi55S9ajql26c08IPH7tGEcdlFp
         RAdqAhxqpwd8pLgX8tKJBkrRSHCpj20ZkMIvnx5dc35sNiw6rzLvKuQE7F5f6yoBPgZD
         ILNtzRyW1ilnINnOP8WKIWBUPsTZ0jp183YDfa3srmuhbfe2fweRas9q8uWnHo0CM1Aj
         g4ag==
X-Forwarded-Encrypted: i=1; AJvYcCURF6KwHoLzsVwRmJnoLDQXZfGg2np9u+n9kG4r7vbYjDUxj/kaCc5ldbReg/H4suYJouLGEa/qQTOLoa8a@vger.kernel.org
X-Gm-Message-State: AOJu0YyLEI5SNZNwJHXhlPD+5LiZF0Rr/6M0x1b586orc5wq+gzIupc7
	NRkrr06BCov9nhhzZRQtNUgLp6QcY2rorPJNNmkyAwXXIOt6B6ng9dFAV/o6JXsrf5iHbA3PlD9
	j18ySqPScbnAXZj91sYqbnNyUzwkDbCU=
X-Gm-Gg: AY/fxX7nbSfIFeHaTDbwgEVg/+TYrdfgpJJZ+88XicFSgcK5lo44VQ2v6LKzmhsZoT1
	69hhGjv1GuZTN1j+eaNgUiowqlQzhW6hfhdAAaVYMzz7bTGa3TIGt6I/96MjXgCV+MotYNLHj1+
	osfFswhrfuYP5xfQA5sUHLVcawvqzpcwsurreNImhXPlZvDdxcJTUwwT6ZnkMm/Egkbx6TpONcI
	KyzAsDXGG/bhvwp97ar/7s860NgzyxhdjpSTNtGbsCzdX/n88gdT1wQAUQFxgDVHI59XgY0MyZw
	ct7ne5NWWFuhEtOribjDL20525U=
X-Google-Smtp-Source: AGHT+IHch8jgRFFgYhCOhfqTD3mp4Gf1xTO8c6j64YajEsIYIcv7McQHhqZ3IyXoUhUPJSsN5RJzXnmyK646gJh5rxM=
X-Received: by 2002:aa7:da4e:0:b0:649:aa32:7c0a with SMTP id
 4fb4d7f45d1cf-649aa32a55fmr235337a12.13.1765539899674; Fri, 12 Dec 2025
 03:44:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209075347.31161-1-tianjia.zhang@linux.alibaba.com>
 <dpuld3qyyl6kan2jsigftmuhrqee2htjfmlytvnr55x37wy3eb@jkutc2k4zkfm> <038af1cc-a0f1-46a6-8382-5bca44161aee@linux.alibaba.com>
In-Reply-To: <038af1cc-a0f1-46a6-8382-5bca44161aee@linux.alibaba.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 12 Dec 2025 12:44:47 +0100
X-Gm-Features: AQt7F2r3VMyyK5p-_ZMmTrPlXfaRxkUPJYgU4M1-m5irAJmv-HOxFCuipIj12PY
Message-ID: <CAGudoHH7PGSPiBkpyzJFS_BcPN_tvp7H5d-pdrGn=ueBUW_Nsg@mail.gmail.com>
Subject: Re: [PATCH] file: Call security_file_alloc() after initializing the filp
To: "tianjia.zhang" <tianjia.zhang@linux.alibaba.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 11:01=E2=80=AFAM tianjia.zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
>
>
> On 12/9/25 4:22 PM, Mateusz Guzik wrote:
> > On Tue, Dec 09, 2025 at 03:53:47PM +0800, Tianjia Zhang wrote:
> >> When developing a dedicated LSM module, we need to operate on the
> >> file object within the LSM function, such as retrieving the path.
> >> However, in `security_file_alloc()`, the passed-in `filp` is
> >> only a valid pointer; the content of `filp` is completely
> >> uninitialized and entirely random, which confuses the LSM function.
> >>
> >
> > I take it you have some underlying routine called by other hooks as wel=
l
> > which ends up looking at ->f_path.
> >
> > Given that f_path *is not valid* to begin with, memsetted or not, your
> > file_alloc_security hoook should not be looking at it to begin with.
> >
> > So I don't think this patch has merit.
> >
>
> The scenario is as follows: I have hooked all LSM functions and
> abstracted struct file into an object using higher-level logic. In my
> handler functions, I need to print the file path of this object for
> debugging purposes. However, doing so will cause a crash unless I
> explicitly know that handler in the file_alloc_security context=E2=80=94w=
hich,
> in my case, I don't.
>

Per my previous e-mail the real bug is that you are accessing a field
which at the time does not have a legitimate value.

> Of course, obtaining the path isn't strictly required; I understand that
> in certain situations=E2=80=94such as during initialization=E2=80=94there=
 may be no
> valid path at all. Even so, it would be acceptable if I could reliably
> determine from filp->f_path that fetching the path is inappropriate. The
> problem is that, without knowing whether I'm in the file_alloc_security
> context, I have no reliable way to decide whether it's safe to attempt
> retrieving the path.

For the sake of argument let's say the patch or an equivalent went in
and you no longer crash on f_path.

The only legally populated field at the time is f_cred.

Later someone might get an idea to look at other fields and instead of
crashing get bogus results.

Or to put it differently, it's a design issue in your code. When
called from a hook where mucking with 'file' is illegal, it needs to
know to refrain from doing it.

