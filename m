Return-Path: <linux-fsdevel+bounces-36206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD8D9DF5DC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 14:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33033281A48
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 13:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E0B1D12E9;
	Sun,  1 Dec 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPjAwfcc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376021D0E2B;
	Sun,  1 Dec 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733060695; cv=none; b=EYFaTDGnqiwFLBntN1n0Gr1nb97emwBRdxAzwnzjca5n90kQBzKISjeaqMsGbEGBOhbGTqegl01fm7i9kvL+ZrcAX4eQbvEZ3BqDLTI1iHlqYQYEhf7VHmXQcw49JHwdVbmzkVbyV+n8KyJIvzItpPCr+KYJx90tTCy5rxgFUmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733060695; c=relaxed/simple;
	bh=/yn0wzxjN0cmJXgeAMJb+GrHSfXq3krz0+bt1dsLauQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5b0+E/j1RW4/8He0Ot0scnS3xaQ4ZnRU9YbEcOzT8NP5TtXzf0fFtxjBd8OR5oLVtn32Oq5QwkQoCyvDZZJS3rJE/w0NcFTezpAvToBy2K6MjsMpxoHjchIqLIzuRrRkL8qdAIe25L7bRuMi8X9cLmG+qBsnfLDHBF8QAbgGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPjAwfcc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa5500f7a75so549389266b.0;
        Sun, 01 Dec 2024 05:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733060692; x=1733665492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yn0wzxjN0cmJXgeAMJb+GrHSfXq3krz0+bt1dsLauQ=;
        b=KPjAwfccbCR82wCfqxs9rlqskJwsB0DD9S8EMzmeaBdUp6PjC6O0AFYnQpE7Xz+G5i
         f5p5wPm+EJBnjwNOsvKUTQtK0ji6G7Imh3hq0zZCsvEZhUf8AFLiZ1dHXOr3q0R+Lzcl
         cHtlwrj4CCiYdlwLHSGIRKAdD0uMIK1hAncAb0V+9VmEhfpDtOQPSzUTc+99y97gIzSk
         f2wvymLH9IG1XHxvHHJ+mpDY6h5isJFMOpbetsJLW5j7t/1a99suvSs1AKWsmBZtuXCt
         3icrt+dc+3RPudz/kLWRaICFZXLifHmJP5yH3Z/yYdik1KoiGHx4KyxR+Zz1veSb9o8f
         31ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733060692; x=1733665492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yn0wzxjN0cmJXgeAMJb+GrHSfXq3krz0+bt1dsLauQ=;
        b=Icm3B0gioaHYPPmXztX+UIAq9GAWFV9zpRRCBk7DxAWLFlX08n4a78QuP0JoIgicTs
         F2TTzGv8MKsWmoiSH9WNN6PpjZj1bdIyzUrxZvlO/VSmd6IfMLM0s84sZLHFW4aCc3+U
         BxDg4PtQ7uONvTR5v1gLUjwveTLpH3e3G8IHHiYS0F8hyteCfeF2Otv9FOXLsbNYH+S4
         C3rcMeFjZfX/8fj8/QfgRoEXr3ICLSnVafiynGiUd45ZvGw72axVxfAkTwTEWFs95oUL
         PnChMscA+SxbJwnC9zULs+vROZ8oTIUhyCfONR5UE65xUHwbrxg0M9U01I1iUaWPsWsx
         1rug==
X-Forwarded-Encrypted: i=1; AJvYcCUuKpmNbp7a574x5EdK3gsRmr3pk1wB7MardS0aYLd1TVrJb8aGWv3GoYFdXToMz5Yhie+RWAEYva/V+0pI@vger.kernel.org, AJvYcCVqIJyChEJZmhJkautrQaCiB6pEJwiCIquAq0LJ0VpEqboIf0nzzLgtNaeCUUjgoHYdf/dtf1vVFCZV@vger.kernel.org, AJvYcCXaeoEaAD2YaBmv7U4N6Odv8eS7LBTADaaGNwMDnshW23ufhbz+lstDGgjL8RgFwi4UBEIMtfhfTF4kuHN3@vger.kernel.org
X-Gm-Message-State: AOJu0YyelXfY7NZrzt3iRA7s4rMiZnV4NYXPlsuZWZFcivwScs8FfwrK
	eI0l7uc0WoLQA5Jyr8RRRGDQImGD1YEtHgx7DQkmtfgYHzrHictr9xXSikUvS5yWTV4ykbAUqvb
	i2X7kSCumm6eFc5vThjIYCQCuM/I=
X-Gm-Gg: ASbGnctC9gnZmmfLdWW7SzQKZJLZsBJVOm8ByhTQfuOfLlw0G1sGf89bth4Ac9zHXEA
	gyA49E6lLrgpvypzK3yqOHX5auhJUyfI=
X-Google-Smtp-Source: AGHT+IE8ktqTmWmitN2gm1HOsLcRDsx1CtpYrdD+9z2jySWMuixmlI+8l45DDQ/lsrmbcZVIINA4AgEnnWvLFZSPjKw=
X-Received: by 2002:a17:907:77cc:b0:aa5:4cc1:1967 with SMTP id
 a640c23a62f3a-aa580eede36mr1456499466b.9.1733060692184; Sun, 01 Dec 2024
 05:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
In-Reply-To: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 1 Dec 2024 14:44:41 +0100
Message-ID: <CAOQ4uxjNEDZHwyUd2k8OLYH9x4xyrsFUnSSrH0E-QnMsHoqmvw@mail.gmail.com>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export operations
 as only supporting file handles
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Erin Shepherd <erin.shepherd@e43.eu>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 2:12=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Hey,
>
> Some filesystems like kernfs and pidfs support file handles as a
> convenience to enable the use of name_to_handle_at(2) and
> open_by_handle_at(2) but don't want to and cannot be reliably exported.
> Add a flag that allows them to mark their export operations accordingly
> and make NFS check for its presence.
>
> @Amir, I'll reorder the patches such that this series comes prior to the
> pidfs file handle series. Doing it that way will mean that there's never
> a state where pidfs supports file handles while also being exportable.
> It's probably not a big deal but it's definitely cleaner. It also means
> the last patch in this series to mark pidfs as non-exportable can be
> dropped. Instead pidfs export operations will be marked as
> non-exportable in the patch that they are added in.

Yeh, looks good!

Apart from missing update to exporting.rst

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

