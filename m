Return-Path: <linux-fsdevel+bounces-54309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F34AFD9B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 23:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB0582CE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 21:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB44246764;
	Tue,  8 Jul 2025 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCJjph1h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061524169A;
	Tue,  8 Jul 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009853; cv=none; b=UmG3pssJyIO05X0vagkLYk5WMdYbYaddwIt1gwtVsMUiM97V4MU2oWNemmejXHrjDSJd1QGtOnzr2c3ZTalm1yfWh80yxSsQeDEEsUe39oG7btd/M4FHgzHf8l11KKF/t8X1q5BTxLuZlmpWIAM9gHLJX0ihD6DkBrrLgrlbHY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009853; c=relaxed/simple;
	bh=TAarUlwoipeJdtGaBy0q0huqZ06XrAcygU/VwbsqJ5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/TzsJSoQ9Ly72TflCvfc8D2pw3tKqHf3xVxSOzVDy4C3r0x3XoSTTAICFMsKzmMA389+zoS5zri+b+s6JvK0iKRMQVOSKZR6xd5j3KufJv8bqYFpze9XpZxW6q/sM/vIuSKraSFhx5OYa0YujM3B9QqMgdMNurG85RO2UPDGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCJjph1h; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a5851764e1so107914381cf.2;
        Tue, 08 Jul 2025 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752009849; x=1752614649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb1DWyul4+z//HafPpBpv8sBo6GJaLU8G6uUisvGiGs=;
        b=gCJjph1hut8z+W90Eh9RqoYuCP5btAzeVdSqF+XjCyYY7WUPLGs6BoJo4D9glX76pp
         nbAcFIZ7h1K5jH+e4m9hPTQQMryEqiE3xDaCxg0dCzAHkgxzRQNHmHkj9LtzRfM629xB
         +19fIG6hTr8G8H06SKGVu2X/GXvGCqaQn4fllcpSOv94+QrYLPRnL5+z1/CRSoNs8hho
         p74vt1l0LhFLrudhfqNJ++ENnCsupqAH/WF4AcJpy1tcELdyjU/eCJdHQLU87xG1Q0WK
         Vq8wk+w/4F9luRu3XGtashLQ+2L6h4btS9cBsLqt0YqobNGNsRDmz6NncNA3tswISdNX
         kfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752009849; x=1752614649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lb1DWyul4+z//HafPpBpv8sBo6GJaLU8G6uUisvGiGs=;
        b=eyMxkc2XHLnrgs05RLDjNLwNxIyzkNl9em2ZudEuSYLd4PASey2Xf5/zdgP6Bwvfnv
         Olec2lRO9dABqhYvYxqUXuqisawU3gJUQS7C9bzvVJU03bnAt9KrgkWzKVUILi4zg6FG
         iPTtp6g60nOD7EzidrYjWgh4Y/IZIyft+ycrZVHOohiQLxIQDJHTPP/sJ9WIJy0hiaQZ
         TyMcB4rlgFkbeJPXgI7kR7Ofoj2PJP+KmrIeCQV/nLbT6f6ylutMczK+jv1ilwmV1vCk
         69DOuJIifuRBVyPVIDBG0UAXmyVizTJU1Id5tMCjxZMVC9FOA5ndbjM5G8AWXdCQSRRh
         tQ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4iIb/IPYDMoely6VSlsctOzFExvC4eSnXY38XXQAvLwB0jqIuIhBp9Ii6DJXF8vEdLe4o7mXaF28m@vger.kernel.org, AJvYcCWU8lql8CX/5z649JR+pVL5Wr18shqz5u4NkejOMGe9uMxVhi5IC4s7oDUwTaeVK9boM2W3nth1wpnz@vger.kernel.org, AJvYcCWaH0hdhPx/SbEtg3/DZDbjk+gxmd2kMxXrjI+veaTR3XdQO3hWMmm6pe3Vbd/Nd/JfizRpURZMZXVLQS5Ulg==@vger.kernel.org, AJvYcCWg+8CUMtLCxgwHODfASZKMoIdtDxBEYInA1or6ttZrx9pGLfyZuH7LscjYn0u/N2ZZZFIpELMoVQRN6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMNCCvrpXOxVnNV2KGD11PWnyt8yp1FAwgsY6MWnnHuLeja41
	1xYyNIIPLeKy4/frxt+3S5OvQJqGrNkuGf03qHgOiJAzhSs+UY8uNbjwnwnPRKq8dOGk4qn3v3o
	Gj3+66xX10BOzf+kd+P6M/IGetBkENKs=
X-Gm-Gg: ASbGncvGneekteM5n8fB23GbxXZpIVuB9v1dIwROr9dxkZyrzSfWHxlpdZbBI+SfDDM
	HDHxsWKM/dL+TLq9m3pkOOQ1b2ch3aYRK4hT2C20Iu3YhhG2zZWGDLPDSBcLUUwITwNBHRMVP1/
	Ce7Ab7OMGiQpFhu847UNdHhSyskaBjf9sLzN277Q0mVTU=
X-Google-Smtp-Source: AGHT+IFMTz6SH0zhjDTLZOgfQJaIbPlc/Q7hBu5Jk+gXOKsGzS+9pZssAMoKgD3aM67ZjEkpBcgMRTo0DP2oOJg2FHU=
X-Received: by 2002:a05:622a:15cb:b0:4a6:f6e6:7693 with SMTP id
 d75a77b69052e-4a9dd212a82mr11067851cf.6.1752009849424; Tue, 08 Jul 2025
 14:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708135132.3347932-1-hch@lst.de> <20250708135132.3347932-13-hch@lst.de>
In-Reply-To: <20250708135132.3347932-13-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Jul 2025 14:23:58 -0700
X-Gm-Features: Ac12FXxgJU6oVRwVQoF3qI9wrV1DgytPuRVdvsm-iLn1Wf05V3VDBvGeBQNSiQI
Message-ID: <CAJnrk1bqfEH3E19x67P8Ciq+8Tp-K7WusDPyzJGt5G7BFyhQHg@mail.gmail.com>
Subject: Re: [PATCH 12/14] iomap: improve argument passing to iomap_read_folio_sync
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Pass the iomap_iter and derive the map inside iomap_read_folio_sync
> instead of in the caller, and use the more descriptive srcmap name for
> the source iomap.  Stop passing the offset into folio argument as it
> can be derived from the folio and the file offset.  Rename the
> variables for the offset into the file and the length to be more
> descriptive and match the rest of the code.
>
> Rename the function itself to iomap_read_folio_range to make the use
> more clear.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

