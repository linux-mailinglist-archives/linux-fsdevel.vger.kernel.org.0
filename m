Return-Path: <linux-fsdevel+bounces-49785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0E7AC2845
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 19:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7686E7A7D1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EC7297A6B;
	Fri, 23 May 2025 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFaQwBSh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C69429713D;
	Fri, 23 May 2025 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020300; cv=none; b=jpB8lH0Jvt7gYlnQfbp5o20e7kVHCK6GtZfzh538g/Gelce2+/L8qawavzLy58nCPeoXb5IwGZNQ+Q1l8ougBelB9Gxg5ENj2FvfTOmebFfL22IXjTaI7ibvdY8BwNqgyTTKczOp1OoV/5vApKldoNngzP8xpioFgK1MGq6C/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020300; c=relaxed/simple;
	bh=ebXiyUSa+rGI+npaItnggCG7U/IT5IZx6jefIxO+3eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAgc6dsLtsI0eA5CSca+WpAozzlR9O1beLm+8zVF3YtFTDhta7/XftQ4RJ1R/QPusyYQWaox59QnayqoPtOnAuEsFHKfeTETXedI0Ahr929pWxH8esPMB4w4ljJYU1WPx3byhlPppSNjsr8XNJc2pQL6RbUCYpWn24CLSoWcl84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFaQwBSh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-acbb85ce788so5171966b.3;
        Fri, 23 May 2025 10:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748020297; x=1748625097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebXiyUSa+rGI+npaItnggCG7U/IT5IZx6jefIxO+3eg=;
        b=EFaQwBShJ6p8CzGosjyJ11yk2nABvMaJPfaOhFeATOfh+HBTZNCyenj5Nbwihz1KfG
         WnOmQLyqRAqb0I01VhIIX5S45ZP5Ba4kHQfTqdcqt+CE3IKBeFVdro8tOq/m1+V6Zc5P
         3dxAgFYHNfMTZet+sB28B6izsV29qFpQXu14oeJDQvBfYS5UnrhfLVVJPXE3/GBw8x0W
         A8KATvrU1Y9Vi7/c5C4kc9qnYIPNEd1IyBmjHADTJBg4H+fKdn1/TUR3s8+WwAl+xAzn
         HduDl1vC3BCGoZ5NIwx3RaSZcvBGWqHuuNCUq7YmXaRw/KsP2O8oW3yKA/tl6JXA2Q3Y
         fJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020297; x=1748625097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebXiyUSa+rGI+npaItnggCG7U/IT5IZx6jefIxO+3eg=;
        b=onwS/oCTTt+RYfZVnbZV3EUpkmiiS0QN53RR6GUEN9wQjd7T0uHWhgy019mjphOWFT
         4OdEs9EiI926bIL8tzbt3aAGZaKarJzCNfWufaokNo0FjgfCVLrs2K/hY45o7IxOZCu1
         56r2vj5rJJzFzNyv7GSvO+Y23Ky8Bmg1qdcDBI1caT5xlY7j5qeH0ujDnrASW1/VoMda
         LHvA5kRDp1JYJXdLjGpCb5Pru6CkhJADujjV4ER2h3K3H8+Maxh1F9V3GL/8XF/snLNK
         9CQAYCpfNBBEXye3WzwSDUNjuaT68F+a1/yx6a/USlWyhxioZQJNQXbwJVMXkSrp4c2L
         taSw==
X-Forwarded-Encrypted: i=1; AJvYcCVlTJUI+H/3IrmDB/YtEGdO3l4rNJiTIUyzPFGIaQNYxO6+zP3bbDvbWJmz3qo1o3TePT/XLNMm6HO6TOTLNA==@vger.kernel.org, AJvYcCX/WPTmmeaJl5YlZQIfigDBdVAMdvXXfX/lpDiOefRY8m2zHZ8B/T8CjDhufkAbUnl14kOI1Ipp@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHjZ61fZhz8/c+CO5VdzbL8g94QTjy+qS+BOd0nFwf3avCjXB
	GEeqPESWYDNbMupqRiw7c7w+eNFOj8xs1kDT0S3HhMiZ83UgaHJhG2vjNYVCEHUnq3BdHz/AM/I
	M6YVV/KL6EMtlBbvNf7ZWdpldHR7K99k=
X-Gm-Gg: ASbGncseim7ydeUiQ64C4qN0F4ZT14TNcKm9uSnBD+wn82tHvH5srh7U1LTb7op6wMs
	cU5WUopH1iBBgaW2WNLAow6mOGlagI0ek8vsHeTV2PgKEi682pa9Gbcm88CKbT/40ADbIPfbYL9
	PAhDbPzASS03Qu4ztcEMZTw3OWWvGYyAIM
X-Google-Smtp-Source: AGHT+IFypcf+X9P/rnxaVJd0SFQ26axRHfFM/eOP9htAsT3Qtlhk8LfnBftlxbRGzQj5iViqf8Q/lZfoJWuThNNXUPU=
X-Received: by 2002:a17:907:f818:b0:ad2:29eb:6ab with SMTP id
 a640c23a62f3a-ad52d49e38amr2968153666b.16.1748020296885; Fri, 23 May 2025
 10:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509170033.538130-1-amir73il@gmail.com> <CAOQ4uxht8zPuVn11Xfj4B-t8RF2VuSiK3xDJiXkX8zQs7BuxxA@mail.gmail.com>
 <20250523145028.ydcei4rs5djf2qec@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250523145028.ydcei4rs5djf2qec@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 23 May 2025 19:11:23 +0200
X-Gm-Features: AX0GCFvW98TBD71TkJXxhgPY4dpNqMxzJmJQz3WHy7mfhfF-cw6txgkBeqr1_9Q
Message-ID: <CAOQ4uxhxvHpfrd5BVKLFYr3D8=v4z1js-XkcODRhXtr0-tsecw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Tests for AT_HANDLE_CONNECTABLE
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 4:50=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Fri, May 23, 2025 at 04:20:29PM +0200, Amir Goldstein wrote:
> > Hi Zorro.
> >
> > Ping.
>
> Sure Amir, don't worry, this patchset is already in my testing list.
> I'll merge it after testing passed :)
>

Thanks!

