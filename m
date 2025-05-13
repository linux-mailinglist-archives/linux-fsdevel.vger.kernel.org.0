Return-Path: <linux-fsdevel+bounces-48914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61550AB5CDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 20:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA2C4C0354
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEC32BF3DF;
	Tue, 13 May 2025 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFK9lrXn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5177DA95;
	Tue, 13 May 2025 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162354; cv=none; b=mQbhU/SEeptKVUbnoblw07ITuBUVYcL40Nl33HTt6FFyqPK4YqVw97ZjsdbS997kD3KxmE9EuI2Wk7XYShgBJfLYF2UY+1F7nC0auqDnqg8uwUPfpesYWrfzGyurXniileX73wMpbKrvKECtds9zr0KnslZFqe2OBRtfaQ0/PQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162354; c=relaxed/simple;
	bh=YLqKvbJCg1Us+vo5VKDiuGKuk0BCiR8J2Bb1OtlOiCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shq+DQBSYsgO0uKg7ZeBIkh4mjclz1acOySagYXFcwgZF2z0CntvZjCSBd318W+BKdHzyLo44GLZmNwH9elUUdGkKgTD8Q/yaJU0rjJ3x1C0h3FaeED+YeZv9SIJTXrBhofHxM6xVBvPkWpJOvZdx376JzO48AkRrDZCMlfRFps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFK9lrXn; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47691d82bfbso108794241cf.0;
        Tue, 13 May 2025 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747162352; x=1747767152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nMKYT0ZC7ThA5iDPskxAlh1th6SMKR9W7nbl70Hakc=;
        b=RFK9lrXnNU0DUbbuDm5peb1pb8nOt7/lEtsFsrTMU5lUMqdbGLsdgYHDVK0feto/Cl
         aINjMceOUjcgNWnCwr5dx/zjKWbr7PRfqm3sYDeY+d9iIgZzH2Dvagu8pYJ94bREUNXP
         itY9Ztedn8+TEZ+fbHd+TisGsDfOUDcFZYUttxM7BvKan2s5AomrwGYxQx/p9a0UsHeL
         jjoJ6ULkUGgRm/4iWwCUWU0k/DT+Ve0cg1aeicb9EdRZKazK/g/sj7sPw7SAhFATlpq3
         0TLMz3jyTKs2nr5ERxYaj+Rs011HMVf9scWfM7ZSxy7IVvaZ7B7hQDbe06pNOZqcWGEG
         wLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747162352; x=1747767152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nMKYT0ZC7ThA5iDPskxAlh1th6SMKR9W7nbl70Hakc=;
        b=OO+t5zOeZMASkXAkLiqHHd7fQ1T3jbUMo/msPWgIONn6grYrL2KlYebMxbWgRJorY4
         0wShm6aL8KHIYUHVgkiJeWDnoxr/gCQQGAOMF7F9aEpx9SHyLgx6G+I/ZK/Q8voonWBw
         rEpd6Kypmw9GPuDCFHcQNwf0DmoaQVIqkReVV1quV+/EAMYN8BkJuphecCYP9LiRJC2D
         DmcJSVGObF1bL36zJEb+zr1AMSB0gC6+sbqW8c3T18x158KjvWT0H0rd3LEEgUfbd1Bv
         O56xxsL13Io0WFMPGhg2to18fMrGZPORVkx3RvMTGf5+V7s+KQPenhx0FVIf/+ZNNuNg
         0O5g==
X-Forwarded-Encrypted: i=1; AJvYcCXHeoGpnpm4W3HHuVcU1pOxkXZYzwNBIQNuhKn5cQV9Fyzc8ZD/jg/+DcyISRXYOV6YiDOmFK04VsMHd1pc@vger.kernel.org, AJvYcCXoyG8MY3SGHmSXgjQ0vC+jIXXv1Xvqhnj9jUl0VnLgFQwPGykuzR6VirJVCfdbBh59thkMjX7X8y9yPFST@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZAME3OCJwU3ChdoJ9dRI009i49nYKce+3o5OTtBOAf/Cpjyk
	0Z63N3pAjn9t1lOWJfA6qyC9UjrtoMjTcT8r/G5zK2XFiGVs9bAVPqPaKpt+KeUCFsdyKulIe7s
	ti6rGIbBQOEhv663GXGGRhPvZmZY=
X-Gm-Gg: ASbGncuh92qd/80l0w3DKR+SHQ0IegP/XiheMDrX6zucqZo7xvPa74ra4inflUz8m9U
	VevAPmLsjUgB10pbibcF8AgrM5xzoiZA33NT7gp6TIhOjyW87NzxCi7B/UjzvO6lpFq67oilAqq
	rNWfHCuNqeZGURdQU/iEnX1JyAcCWrr2dP
X-Google-Smtp-Source: AGHT+IEOkn6Sl/r23wxwAf3KLFAVdmt8PeT0S2jSe4ss+3PbeSYwN+wLvFx2QZnC9oB0lXXCiJnU/RPpUIewEBJxgRk=
X-Received: by 2002:a05:622a:410d:b0:494:848e:d703 with SMTP id
 d75a77b69052e-49495ca4f3dmr9260291cf.30.1747162351842; Tue, 13 May 2025
 11:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <CAOQ4uxjDwk6NA_UKiJuXfyY=2G33rruu3jr70pthFpBBbSgp1A@mail.gmail.com> <CAJfpegvEYUgEbpATpQx8NqVR33Mv-VK96C+gbTag1CEUeBqvnA@mail.gmail.com>
In-Reply-To: <CAJfpegvEYUgEbpATpQx8NqVR33Mv-VK96C+gbTag1CEUeBqvnA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 13 May 2025 11:52:20 -0700
X-Gm-Features: AX0GCFs6ewtIyYM1WARmr2VDGdo0IYurS-hAVg27gXMCBfR_WcFJ4d72i6l9ocI
Message-ID: <CAJnrk1ZxpOBENHk3Q1dJVY78RSdE+PtFR8UpYukT0dLJv3scHw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] fuse: Expose more information of fuse backing
 files to userspace
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, chenlinxuan@uniontech.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 6:23=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Fri, 9 May 2025 at 09:36, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > This is not the case with displaying conn, because lsof is not designed
> > to list fuse conn.
> >
> > Is there a way for userspace to get from conn to fuse server pid?
>
> Define "server pid".
>
> One such definition would be
>
>  "A fuse server is a process that has an open file descriptor
> referring to a /dev/fuse instance."
>
> This definition allows a mapping between tasks and fuse connections to
> be established.  Note that this is not a 1:1 mapping.  Multiple
> processes could have the same fuse fd (or a clone) open and one
> process could have multiple different connections associated with it.
>
> This might be sufficient for lsof if it can find out the connection
> number from the fd.  E.g. adding "fuse_connection: N" to fdinfo would
> work, I think.

For getting from conn to fuse server pid, what about adding the server
pid to fuse's sysfs info? This use case has come up a few times in
production where we've encountered a stuck server and have wanted to
identify its pid. I have a patch on a branch I need to clean up and
send out for this, but it adds a new "info" file to
/sys/fs/fuse/connections/*/ where libfuse can write any identifying
info to that file like the server pid or name. If the connection gets
migrated to another process then libfuse is responsible for modifying
that to reflect the correct info.

Thanks,
Joanne

>
> Thanks,
> Miklos
>

