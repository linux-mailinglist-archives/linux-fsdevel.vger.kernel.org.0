Return-Path: <linux-fsdevel+bounces-54149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 010C9AFB9AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F7D7A3C8F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1F228726D;
	Mon,  7 Jul 2025 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZntGHPj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8DE27AC2E
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908407; cv=none; b=BBwimLWdlZ1Em+V8dWZbJUV1pqFtTl9IJ7FYjoH9DHuJXpJoQ18Taw1owo/P3YdUmzoxh3jyDb3MJk8V37pVq/OC/VyN7a2FAvyMntXp3hWd/wdU/x7xoXhy4EzgdlGUauDsgsVc6SMGB1U/Ubqc/tSrY6DJL007F2KEMAGGliY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908407; c=relaxed/simple;
	bh=c2fpjD51tZi3F4Esxe5ZHpVZSFeD7xDlp/+WOkOV+zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5jYYXAd3hQWevvoblmqJFW5TU8THijl5rDNJJawfRlk0zqZfmfBnqtIxWaNI9cL2icuKqIGvLUlpUMyK1Zjk7Uft9h18sxPwcUcpDqKbn0VbA4yIGGwtA/Bh7b4aprTq4CG2nLWEgAZ0pbH/dk+2oGDVMOxc7o/PY/yJH9MHE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZntGHPj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so4691530a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751908404; x=1752513204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukdW1SdATi4lB7URsd9yMJ/e4RKhgbd3W66iWSHWpMo=;
        b=cZntGHPjI6NrWF0Em6eZ4ksGpQaZAxuExX9B0AnXBqJ5dZJbz6ZVA6EPv5yEv9X7o5
         ImhL+/TrRjhelBVi2iYCFDiRi5xQOVvlJ4tfe8urczFGqD75B+JMDwYgeEKKL/N8P9Rw
         S+GIrceCClWJ1+ACJ5E0OmSwYSvYi7besL+NKc5dSaoTi7EHvE2zISSYLttPrI0TxB6O
         FdZ2cXlseiPnrBRCt77d+FAvHGkXQKSNjNw2n724zYyszzGCA/fip5Ae5Pb4+oZRK3gF
         39+BAjomxML7DNvfs/fiVNRKxLJmBimO6iQUKsPDBcLnzHSD2D7liS0H/UjpPiCZ6t7z
         NuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751908404; x=1752513204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukdW1SdATi4lB7URsd9yMJ/e4RKhgbd3W66iWSHWpMo=;
        b=X647cbpWqty7D5NH5DWlh8FTogBXE1IhC23wbkaE3yOWPOId1yP996/BB6KkbpEDqS
         heKNkoI9QCL1tESlCCP9wVipBsj999ymrRtx0c4ohF2W+VZ6a94Ah8t/p5gUvwGRceVn
         UHYj8iR6KZ/Vtrr2dzHPWGnKUsiZPd4/8ZXtmz5I64ZagRuaHTcCjbiIeM241GKYKJRY
         8j5RQUPHN3INYKXolnSp8fHH4dFqR8OqOcP1QFiZP/Okr4w8LEBD/ZaJ0DmmkOhQEM1N
         Q7tbOeaR1P4Kl+xvodxZji+WAMLaE4UqOydWPTI5ShRvxWl6JMML1Bnhej5VXV2qv6aE
         Yhnw==
X-Forwarded-Encrypted: i=1; AJvYcCUARXXCVnh6wg0hz42D9j08fJhWAK8HGoq0JwGZAAgEhYvKshp0a/ITTW03kDLaUqmaVycDN9Mzvt2wFCU4@vger.kernel.org
X-Gm-Message-State: AOJu0YxmtGSXwiKicSc6rPGndfGZSy7mtnL4IkuHyp9KbrtBzxJ+c7Gq
	YNctV7R+qVJZzteEMTdcLHboEhIy4dc1Lz3ZfqOZlfs/KkcP0acGaeMl893UXzPFXZmX4I/qeBK
	TNHXE7i4e7GX8kNXXiWB1OYIYvFt2OEs=
X-Gm-Gg: ASbGncsy0vyNICcXjlMMdsaO/8HpxufFlY1rznqGbEbzVRFUBFy6xxG28+uMc9XtXad
	5Peh25Da71JTdXK6nDQcqIz6v8x2FUljOe1SIP3qVCWFDtfag0W6zsXz6shQ3NcyUm4RFSF8bF+
	oYb70/4TsdB8/0ge0SX5UtTj+malY3wF0inCyadUm1eyY=
X-Google-Smtp-Source: AGHT+IHrLv/TOzMlN69kT/wTXRChSzi+fncADv7wZMIU0LO5AeY8JmASV7xsJ/0pESGObL2jMZtBzNEXFAF1lQl/XtM=
X-Received: by 2002:a17:907:3e8f:b0:ae0:d804:5bca with SMTP id
 a640c23a62f3a-ae6aff9fddemr6753966b.17.1751908403806; Mon, 07 Jul 2025
 10:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707170704.303772-1-amir73il@gmail.com>
In-Reply-To: <20250707170704.303772-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Jul 2025 19:13:12 +0200
X-Gm-Features: Ac12FXwiWW47jhdjdoKEdQscvygmT0_se_VlpCpKepjbG3gpS5mXczst3kiRKRA
Message-ID: <CAOQ4uxj4b9n8ioWnv8j8pWNU5kqoRhXU5cC=TqmiSB3Wkr8KXw@mail.gmail.com>
Subject: Re: [PATCH 0/2] More fsnotify hook optimizations
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 7:07=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> Jan,
>
> Even since we did the FMODE_NONOTIFY optimization, it really bothered me
> that we do not optimize out FAN_ACCESS_PERM, which I consider to be
> unused baggage of the legacy API.
>
> I finally figured out a way to get rid of this unneeded overhead of
> all the read APIs.
>
> Along the way, also added a trivial optimization for non-applicable
> FAN_ACCESS_PERM on readdir and prepared the code towards adding
> pre-dir-content events.

Urgh, I mean non-applicable FAN_PRE_ACCESS on readdir
referring to this finer tuned d_is_reg() check in patch 2:

       /*
        * Pre-content events are only supported on regular files.
...
        */
       if (d_is_reg(dentry) && (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)) {

Thanks,
Amir.

