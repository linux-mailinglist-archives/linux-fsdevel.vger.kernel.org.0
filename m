Return-Path: <linux-fsdevel+bounces-42594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F205CA44909
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394C588771D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 17:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC70D1DF993;
	Tue, 25 Feb 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFx28uud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551716130C
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504950; cv=none; b=MMbFKB/3JHqesahNkwM8l6oAP2HrcyD8k+H53tHo+OHDjGaxUDJAytnDK8JKNO0UBG+ilPdxqmiNC0iR2Gj1gK44J3GCOKDmq3smPZgV/iQE/uVPFSp5ZTwP3lKoCcjVGQoNf6WCKhBzc/eDBkuaG2C5TwaoS8Mvj5A5MKVAAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504950; c=relaxed/simple;
	bh=0UL+cwoOTTi+pk1VYOZGOcKux9pLiY0WQzL721JuyZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+sFklLE8x/IeIW0t+0AV4lRgNlWYjTNSbDjrRnkeTR4ZoZiiSbybKInbJY112sDK3ArFhAWgZu+x2LxupJIu10jR48y9TpwpRlW7xAX9lV+Shaou20ogOvv4Qctupn81smUKWOANeBsEZ+6zpsgdDldCr2XTPOLBBB9yV4v9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFx28uud; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4721325e3b5so49130141cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 09:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740504947; x=1741109747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5OraMNzgF16UL7KmwygFKRHQsEZ4Z5uKKgjIJoBsnA=;
        b=VFx28uudQLAvpg4cYyqeZ0tSuDZNGmVrz/J0jcuAg36mGxxT7m7iONmEx5lxieTyfw
         7BqC7Vmfv9Xq2rSMBMM/lEjr0WR9Pb0mvlmL040MJs+jyZrRTJuMvVK+RFMDOru/FNe3
         LU/rqdcG/MxVCkMgfX+9JDrOysLG+voZ1xedcrvnG5cQIWGhO3BnG4PYo6Sg3bbSLZlS
         gw6B53eRBKk+p8TkmUN77kzWeeFGBUs2sKhfwMDRa2XqIPQTmM5n4PU3/2R5tSRz66Yt
         aBpA/8+kWMEb4NqbCJ/+pJFE/0PyC4GgGfSZ3d526/Y/6/h3+DDDQFlFQWYWgjfgzy03
         470w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740504947; x=1741109747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5OraMNzgF16UL7KmwygFKRHQsEZ4Z5uKKgjIJoBsnA=;
        b=MSi0ovud+lrYlSY1nGgh9XMC4uP9mulC19owB0rtVh2ykHK/hdjZSJ/lOMn87IdOfD
         zv8I7JWMbneKeJObCCz+u4dfaWZQY1j4K27pAbT/kS0dFttk+aLbpI/GqbzX5eY2eqq2
         OF5J208uskot7pOzB18FJcvOBIs7PQmH7wOwV+r9G+zMY8iUW46q/zwCFEj0MGJ0wHDR
         aUe5IP8vlgj9FHyJclhBjQPD8x5tC8mEm8mjUBc9vR6Ql7M07sIKBvjVcipIivM5rRTr
         YbzozN2mNoQVWfSwV0CVEgyYboFkcX9YUTQBGfUVfrgQlRikdzZEW14s4SHgCjgXAjvC
         r08Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiG9jTMnRRWKkuV7/fHPtFAt0dV2KLIBQhamLtQmUzmPdWSpIc9ovbFM4T8VydU83Go0uW6Ho53TfcL4cP@vger.kernel.org
X-Gm-Message-State: AOJu0Yziq8iSuSfc390ZT83jC1WRMBtlc7vK1kjzMNC9Q3gUw5ICiBEt
	SM+yOxVbnkFYVhLcT9MmBZVt/2qIfN5qTnb213/mEH+98T0ITzbwMFlsyMkFKLkMBcM1P7ktxMv
	qalzuFddaa+M63pQft4/KQdVJq8U=
X-Gm-Gg: ASbGncsVoz+hVjWtZKzqQAPrTi5U+VJD6hQ87BPG6omOIg6fLYH71pwnRrjo6+RLWr3
	048RPMwiRWhvzc25cr6yxZgeUv3InQBXHB1xw0vkfmOiEjwPU8UyH/T9zQks62MzSnKQNR+mJ6y
	OqmJ69MCRx
X-Google-Smtp-Source: AGHT+IF6S6Octg6FHzTJ1S6qGg2ORHkVudFTRavue05jvHHUep2WlGajY8HndT2URnMFo2DOkIR1m2VI7n42V/Assy0=
X-Received: by 2002:a05:622a:3d0:b0:471:fef5:ee68 with SMTP id
 d75a77b69052e-473772707bdmr61950071cf.46.1740504947591; Tue, 25 Feb 2025
 09:35:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215528.1270478-1-joannelkoong@gmail.com> <4hwzfe4b377vabaiu342u44ryigkkyhka3nr2kuvfsbozxcrpt@li62aw6jkp7s>
In-Reply-To: <4hwzfe4b377vabaiu342u44ryigkkyhka3nr2kuvfsbozxcrpt@li62aw6jkp7s>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 25 Feb 2025 09:35:36 -0800
X-Gm-Features: AWEUYZkbyrykU5bZ3V5j1jRIODlvNjoZAedFtL0wdY8HGq2gSco0sx1JjW8TrZA
Message-ID: <CAJnrk1YnKH2Dh2eSHXd7G64h++Z0PnHW0GFb=C60qN8N1=k+aQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/2] fuse: add kernel-enforced request timeout option
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:04=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/01/22 13:55), Joanne Koong wrote:
> > There are situations where fuse servers can become unresponsive or
> > stuck, for example if the server is in a deadlock. Currently, there's
> > no good way to detect if a server is stuck and needs to be killed
> > manually.
> >
> > This patchset adds a timeout option where if the server does not reply =
to a
> > request by the time the timeout elapses, the connection will be aborted=
.
> > This patchset also adds two dynamically configurable fuse sysctls
> > "default_request_timeout" and "max_request_timeout" for controlling/enf=
orcing
> > timeout behavior system-wide.
> >
> > Existing systems running fuse servers will not be affected unless they
> > explicitly opt into the timeout.
>
> Sorry folks, has this series stuck?  I'm not sure I'm seeing it
> in linux-next.

I'm not seeing it in linux-next either.

These patches were merged last month into Miklos' for-next tree as
9afd7336f3ac (miklos/for-next) fuse: add default_request_timeout and
max_request_timeout sysctls
ac5eab212a58 fuse: add kernel-enforced timeout option for requests

but I no longer see these commits in his tree anymore.

Miklos, why were these patches taken out?


Thanks,
Joanne

