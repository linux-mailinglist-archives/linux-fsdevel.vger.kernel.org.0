Return-Path: <linux-fsdevel+bounces-48943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB1AB666F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 10:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3067170F79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 08:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CAE22129B;
	Wed, 14 May 2025 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kf4U2n9Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63721E098
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212653; cv=none; b=lUgH5E5r9iBadJf/976SX2jsnanTgcLgduSLiV416fGxbD5sYlNxw5+z3MTy/hv9fQbGYnCjaux8AtabpQqdkZ/2RNUinDh58mzqG0aNxtBHsxnQyyl3DkraiTgvV1Z02XCKOJrEfTXLEEknzs/d6dHDxvnmv7pbxF1chraAiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212653; c=relaxed/simple;
	bh=tSX3jA/HXWZCcxkvdPn0B4RRhN6070u7urtspGwQs0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHIJmX5ikS7gUUcmVRFxBHKG07Smeok99C/JNNxNplc3SSdddkJH84uL4DiXn9ps084jW2CETrjARnKQXP9LOzv6WhizD+QtZuG3R8Uzck7jevydB2GYPK1hfW00XcCcOYd4PkbhB7DiaHW1QmD9lDFZmBtaykkHYtsBMNLJSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kf4U2n9Y; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-48d71b77cc0so81321351cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747212650; x=1747817450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tSX3jA/HXWZCcxkvdPn0B4RRhN6070u7urtspGwQs0M=;
        b=kf4U2n9Y1ExQpfzS5NuhX7Ta/Yr/x6hsB89cupFjqJXG5Joi0c0f0k+st1HHPeumMJ
         A+Swj5610n7rC2V/bTJVeJLn4ERsHqeGP0sT1gXDDNjbJ5+q3UaSKd7IsJ7uqwwydrai
         0Nd8tk3J5YvWDNM2FhswhD5eX7hsi0oyBj+es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747212650; x=1747817450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSX3jA/HXWZCcxkvdPn0B4RRhN6070u7urtspGwQs0M=;
        b=Fennxs1/T0yEbJgnMnEHSpBC5pyXgcn6C8bUoG9p29zXQeHSsBDcvVdv6dmO/zLuG7
         gXRrfEMtKjgSmcsrhT5bLO2G+pwzgh1vR7poJKL3LLSZD6h2+zxdfBcDl5+SQ8XCcYEi
         GHg0oaHohABBygnW2uM7HIx15nkimWHN570oVATMb4NbCIgZO3x9u9bEYD4lmobL6ydH
         lkZZa1lBzLtS+IDLfxl8tYE3DQFw5aiR50UICicXEv4lO3OxZIjiXnMYytP51zx/2G/X
         uIkN4aHGctl12js+cmqAKZkTRSHtYPz+Lzu14W3u60tvUzSi5wiD9M3z0RN53JvtKggw
         UshA==
X-Forwarded-Encrypted: i=1; AJvYcCXULXCSD8XUfrhbihy692dX/A19VJX3O8cob4Bs6xQjqAIhZp5lIn/b6eZ0rodV2usXI2ceHutc2R8ESO0O@vger.kernel.org
X-Gm-Message-State: AOJu0YyIRRiiDfDzUnhWMgMw+yUoNF/XOj0T/In9Pc85Ue9Q0I+PFmMq
	/p0/vWPtRcBnrk4E0kOlwskz+ohzWLKCUoIe2S7o+j3NWSdqV8xr4XhufOKkmtBIyqZ2x0cs/QL
	ahuTo0/uj5rygrJtVA7CYRhLyPyJAcKdGnjWhCA==
X-Gm-Gg: ASbGncuSxYT8Kf/nTRFLVxclX41XaK2ZyYjvOMV9Q+7StlEkhkZfPqlGemcWBVKSDWD
	q5HJ22WtE/kNUb08/ivm7fHEUT70Gh2wyR9fjZMkV7dhe/GLMcxtyV8rRrzKky1F66eQJF6t/td
	PTB1vxRBOYrPoXhOdAsdp85hw9FDeUdIxpJ1LE64eTAA==
X-Google-Smtp-Source: AGHT+IGLeCzQIwc32fG1czjxbITqnFTOhdsSRGzbFubUyBG2WFIbL35MyAP26FPslXlF8Vxt+OWDfIGfCB+vatsKBm8=
X-Received: by 2002:a05:622a:2517:b0:477:ea0:1b27 with SMTP id
 d75a77b69052e-49495c911b9mr36262961cf.26.1747212650345; Wed, 14 May 2025
 01:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <CAOQ4uxjDwk6NA_UKiJuXfyY=2G33rruu3jr70pthFpBBbSgp1A@mail.gmail.com>
 <CAJfpegvEYUgEbpATpQx8NqVR33Mv-VK96C+gbTag1CEUeBqvnA@mail.gmail.com> <CAJnrk1ZxpOBENHk3Q1dJVY78RSdE+PtFR8UpYukT0dLJv3scHw@mail.gmail.com>
In-Reply-To: <CAJnrk1ZxpOBENHk3Q1dJVY78RSdE+PtFR8UpYukT0dLJv3scHw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 14 May 2025 10:50:39 +0200
X-Gm-Features: AX0GCFthxfZY97wXLqodWfQQ_45BmPxv7EIaJAcSOrNefrHrtSaWnhjOExjHadc
Message-ID: <CAJfpegunxRn3EG3ZoQYteyZ3B6ny_DG1U65=VX25tohQuHCpVQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] fuse: Expose more information of fuse backing
 files to userspace
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, chenlinxuan@uniontech.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 20:52, Joanne Koong <joannelkoong@gmail.com> wrote:

> For getting from conn to fuse server pid, what about adding the server
> pid to fuse's sysfs info? This use case has come up a few times in
> production where we've encountered a stuck server and have wanted to
> identify its pid. I have a patch on a branch I need to clean up and
> send out for this, but it adds a new "info" file to
> /sys/fs/fuse/connections/*/ where libfuse can write any identifying
> info to that file like the server pid or name. If the connection gets
> migrated to another process then libfuse is responsible for modifying
> that to reflect the correct info.

Fine, but then why not just write something in /var/run/fuse?

Thanks,
Miklos

