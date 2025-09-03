Return-Path: <linux-fsdevel+bounces-60141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF99BB41C22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 12:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FBD5E8553
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 10:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D50C2F2911;
	Wed,  3 Sep 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NC1WibBO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD1F2F1FFB
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896229; cv=none; b=i8+TfgbUrWS6r+cLXhTHcK+1yzqOmrsxLNnBv1DSGNJClKQmNiR74IJPVhebvm86p0ZdgC+yaQalz+KKbfy3voXgOki6Q05C7U3fzBp2+sJXw7iyTkHG+1TcALWcKcJSlOHuxaJ3c+ASiL5vV3mCHm9NsDDVFrVhOMG8cYxwAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896229; c=relaxed/simple;
	bh=jA4fhZCpmmViwz34NUXstoDS1Gyf0AyiWUx/qMxePO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrjxNHEKISP/tGB9voHkUOSsIpLNbFvo3lJkE2aWwvoOpzQt6ZdotSnlmzV3HAFBe7k9hN1QAviRtpbVIRaweIduZ9j8QQGFcq4Wmdc01O5BN/XbNEQdR7ejo7U019mtrpLUaN1jcwRe3hupSswmvhrnzAlUSjLq4XAOx2nz9WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NC1WibBO; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70ddd2e61d9so68670356d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756896226; x=1757501026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/+AbusHADgd64/xSqxg+Fn+3RXgNWQ2YZiRgScHXD/c=;
        b=NC1WibBOA4DG8+CZk0cwApeIBqejHza7tV9sAbl/ckPZS9Gh8pFV5d42L5EalYmwuy
         RWANFKSAWlIQgfS3xoMyXCcHriuUFXXypDBZHNfihZR/QjVW6FVad9lr9cX9obsHy1K7
         H5A6JJ8EIlwYEmHbsQe+EyJxJMEuz1X+D6J04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756896226; x=1757501026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+AbusHADgd64/xSqxg+Fn+3RXgNWQ2YZiRgScHXD/c=;
        b=kYZPH8kBenMMqjIILydhX/hCwpbwWkzpTs+8fNjH4ftTNoRwXRiDFwLqShSLKsfnas
         CSCjnDYjL1Fxy1j4txoJ+Gzff4+0iMWY6FmXLFUgBHl9fRiCTEpZOSB9yJCVRn5pwoOw
         U8hquSKsL0JpGpW/QgEgdrzJZLWSSTEZTPJXm8HcxFDbRriarJ0x7UqVAk7iJ5a8YEez
         hyWzRIpk7X03pDuk6v+Fl3THefielrpHmB4nHKvQqpBDNFFdseaZ8uyXjNWYy5ReokpX
         ojFWiX7mkkyukkVEaV/8JN0PsR5kgZBpCVrozC6s2G0JsXaSGevWzaSr619bIOy1liOc
         67hg==
X-Forwarded-Encrypted: i=1; AJvYcCX5MlEdp537raM9FsYgfK8qDW3d2hYstQv3XtbUGyFIhMELwltk7eAPyz3qUWe+7pyp+o9jLFUO5U2bYfCq@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqXWJCYwzmARyQYz8LRFkgymhcayozzu99YBhHzzIfCZR6ZLE
	qj9n7SP/Ee4MEuWE94GSJQP6DEAs0PZLLK8/dWjGZgcHAaPDG/aVNIx7BsbQHFEIqrRZf5YkH60
	LNxYlaBpDnVGiDLAlECSBo1Riqb23Qskcz5fApfJARg==
X-Gm-Gg: ASbGnctPWXrkczbFeBx9EBGgS5D8hLA/lHSopDblyUrEuNURdHa061qTaf/X/v4hgkp
	Y65AwGT7kPy3d9LNHet6cz7g+OPlXw0/mM83NzSu66jWW/bLBg2gONBbTSHEcZr/iMba+FxKMzm
	JWl7TOSRnvqczQn4arA30l/goJwUGrN4LAJDhA3S2fIzlg2UuT9W002Oe0r5Iwtt+Hrn2mWX22g
	k6Huwa9zQ==
X-Google-Smtp-Source: AGHT+IGEadlHDTUG1JVXJAaV6u/8HZQIJB/C+wPqC2jvVH09h2KzIkV+ah4uL29QVUVdPTJ1qhcPJdyH7ZmDf8tETPE=
X-Received: by 2002:a05:622a:1a86:b0:4b3:c09:e818 with SMTP id
 d75a77b69052e-4b31d86fc39mr172222601cf.34.1756896226383; Wed, 03 Sep 2025
 03:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902144148.716383-1-mszeredi@redhat.com> <20250902144148.716383-3-mszeredi@redhat.com>
 <87ms7bessu.fsf@wotan.olymp>
In-Reply-To: <87ms7bessu.fsf@wotan.olymp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Sep 2025 12:43:35 +0200
X-Gm-Features: Ac12FXy5BKh9hwhWjlxJ15-qFzIFKtxtX6ZwtsPMe5diYMt0HlezzaT0fEeH9Ss
Message-ID: <CAJfpegtwxeu-G=Mt7FKdbGiF=OB8j106gx+TGUZN3_tfjC4Tkg@mail.gmail.com>
Subject: Re: [PATCH 3/4] fuse: remove redundant calls to fuse_copy_finish() in fuse_notify()
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jim Harris <jiharris@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Sept 2025 at 12:26, Luis Henriques <luis@igalia.com> wrote:

> I wonder if these extra fuse_copy_finish() calls should also be removed.
> It doesn't seem to be a problem to call it twice, but maybe it's not
> needed, or am I missing something?  This happens in a few places.

It's not a clear no-op, since the put_page() for the userspace buffer
is being moved to after processing the notification.

I don't think this should cause problems, but it's something that I
wouldn't like to do without a bit of thought.

Thanks,
Miklos

