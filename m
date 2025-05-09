Return-Path: <linux-fsdevel+bounces-48623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FD8AB182E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB11D1895557
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D9722DF9D;
	Fri,  9 May 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kKzZm9cq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C51DB124
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803794; cv=none; b=aNkvfuxwG/QbKpyg4R6DTYn1nTUnPdBh6XuIfnDpoCiyf5AVho5kqgQx6r3VzzjxF7r7YbK1+Es/WD494jHCIadNY/Z/a1+gZErGXXU72BBJgfAb/EGFcn1xxKpsrDQ9BNv1I2iZ+Qn2W2kydMBjLgznTVyuT3YYOf/oWgxpyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803794; c=relaxed/simple;
	bh=/lUHvKx8B6SZJ5x6T9rqewPsosq1uT9ayxteuD9sIFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSu9X9Lk8Vonxvrp1ahMB4k1FA8IzZeUvYoQxp7NbKIH+ObdQTX9wvYf+VtKywUoD24Y2woS6zaIhGM6lHzmBBkhdjpklq+Cy4095XTgxe++CsS72Cp39L0HlEvONulW3nIU1WC/qZHRXrNumPYuPNLaXqjcJ84QhWKqaK3ZxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kKzZm9cq; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4ddb1173349so747348137.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1746803791; x=1747408591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1vjIEZsxX3cmymkqbeTODeZFcX3XnuYXcMXlg9gIa0=;
        b=kKzZm9cqkz0M8ljECTyH2IYuv1c/SMh8fUdemOZXjXbxVCm+PG9sNOJJQV+TWdQ4a3
         lfKRH9VgUwgcz8q5h99UFI0G3GbUuHhUUgHFcs35BvbtRK3Txt5VqQTmPSFda8gjo4R9
         EDN30atQ0BKS0qME8omSiYjzKM7ilHrJW9v64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746803791; x=1747408591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1vjIEZsxX3cmymkqbeTODeZFcX3XnuYXcMXlg9gIa0=;
        b=FkY84WjA9Wzfw9J64wsn9rhBOk2EtAocWeSG8h67HlcPqSNz06gmwt7+i6PHGWnKw7
         Sny5YbRcVr3HCQqvqKxIXtb987VLeeXRzNpY+o9DSvHZh3NL3cmvSESdmg0p/3o5RQwF
         xxMMgIjydTH0wSd/8834asHhIyDc7O8KB5gM00JB6sN8Iu6MkXa2Ezp381LDPYmjQCW8
         CifsV2dAq7vO7RE5HpvmwJRS/WOLj8OZ2vnEMUhyIFTsrJ0/8/93OwEyFJZANzXSvbhX
         CES22Zf9TPfOTJRNCIe6pxZQ9q95iFf+nvyHHRN7/j0LFZsejbeBLkRgDKVJq1wYmLee
         TY8g==
X-Forwarded-Encrypted: i=1; AJvYcCWnxY9EDHHbPP6D+dMHhtll89LoQEaQSO3nMfCZk86kge+eh39VVEKctUFYD/tuLQZ5lK5y/J3lsQ8iir5q@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfiOzWrobnOj9kQZ7nS/jpPSKMo/f/ecf5J+kCW4cJn05nWw4
	Povb4BioG/w2Iz5mARRRFPNDSj7ZVk4FPwY8hhRa9DbBnzS2K3FuqgvWzunKFLEMLY/uMZ46VAt
	JpyjTgifkSRxYe8qknRHXbpNyT8hRWcnHu6q8Or9fAgr6hJ22
X-Gm-Gg: ASbGncuq0CxohEM7O+t/9R7l8kaP1AKu8NZmJEGeRoXWaNfb71wi+aEGPmW5Nbnkp+B
	cdJzI8o6bmOdx67KfdK5AM+XkfZPI4JOf3j2CJNnmGqgqNvxwiyfxtXlINJ45VatXoL7dsPqD9D
	GbGMxgqOAG7L6aOp3rz3W7Eq9D
X-Google-Smtp-Source: AGHT+IFliv6k+QiBSpaqMzGO+mimn0fx9dJObJL+mECZXgnCPAGA4+Lphwg/oH/VOOvYw70gEcH6XSp7M7YvmV8KJ0s=
X-Received: by 2002:a05:622a:1ba8:b0:48a:df4a:cafa with SMTP id
 d75a77b69052e-494527e0dc1mr44322841cf.51.1746803779851; Fri, 09 May 2025
 08:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
 <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
 <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com> <CAC1kPDMweHDtktTt=aSFamPNUWjt8nKw09U_2EqyDNu28H6WWg@mail.gmail.com>
In-Reply-To: <CAC1kPDMweHDtktTt=aSFamPNUWjt8nKw09U_2EqyDNu28H6WWg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 May 2025 17:16:09 +0200
X-Gm-Features: ATxdqUGN1u1bbPdP_oEYzlaSAFIoFBNum5f1Y6ZsHZkVMZADh61LHYvK7YaCw1A
Message-ID: <CAJfpegvqSsa7XyQyO9ugv0=tLhLDg8GSyd8HO8TG2e_nLxJVHg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 9 May 2025 at 17:11, Chen Linxuan <chenlinxuan@uniontech.com> wrote=
:
>
> On Fri, May 9, 2025 at 10:59=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
>
> > And that has limitations, since fdinfo lacks a hierarchy.  E.g.
> > recursively retrieving "hidden files" info is impractical.
>
> What does "recursively" refer to in this context?
> I am not entirely sure what kind of situation it implies.
> Do you mean, for example, when a fixed file is a FUSE fd and it has a
> backing file?

Yeah.  I don't see any practical relevance today, but allowing to
retrieve any attribute of these hidden files (fdinfo and hidden files
included) is a good thing that the flat nature of the current fdinfo
inteface makes difficult.

I'd argue that many current uses of fdinfo could be enabled with the
listxattr/getxattr inteface and would improve usablility (no need to
parse the fdinfo file to skip unneeded info).

Thanks,
Miklos
>
> Thanks,
> Chen Linxuan

