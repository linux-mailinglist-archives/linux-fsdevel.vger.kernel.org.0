Return-Path: <linux-fsdevel+bounces-72411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F30CF5D65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 23:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A87C630754D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599F627D786;
	Mon,  5 Jan 2026 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERRvTVJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF08F7D
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767652254; cv=none; b=IB3Wk7+vrQkhM+JpWBhtveZ9PZwx0LlB5X8DMY+6dBjyl4NlddHW/ZdvzoFEC+JdCuoZcLH5FnGx3k1ATR43dCfYKlqoOPodt1MKJASFlrzZVUKwP9dZxHDHsXVtT/nll08VDhvLO2iMUkpEu/B+xO56SWrjQS+fRZtLE9Oum7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767652254; c=relaxed/simple;
	bh=5TSiCGHtgVwG4QGQWtbePwrqqtBM+EEwuz9E6PZ+cbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWRcdNUMwhk/HCPKnI2ViUo9FXjgH18idTlGzaz2TLMh9cQ99dF5keho5Y6x/ubWxYnf0zHz4MRAYcCKA7xqN02gvxdljEK8kTQp6JLsuYGm7yPoqxeZHko9NdRK/XrMmwDM0JBcQp5jANDNipjs/REKJnakCvFHnf9OZ2f8en4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERRvTVJt; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed82ee9e57so4587681cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 14:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767652252; x=1768257052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TSiCGHtgVwG4QGQWtbePwrqqtBM+EEwuz9E6PZ+cbA=;
        b=ERRvTVJtjTPVtC75bUcqKhUjhJMpemF7+S0jJYNvehSgM4mW12+424o3wgiUJWxkrv
         l6alIVHRaM62GjT7zaQi7qQGs63Od+FmElgTe8ajf1M/T+pmL3LG+mqhSMhMPKaiCja6
         P198vGHeJASwixzU7W7xBqKwxUa5zU6VsAeL3lV5C0czVsetn5a4DtLYe/KGfJ7jGitn
         PLk3dJLz4bTywpLW/VVzzP6jUGGKa1LEE6B9BD8+KI/IByf00pY2KOQwniTJhd4ONqbg
         A6niNor/sWFZvkgnS8qq/G4rMb/umZ+8OuvR/YC/MNIy+yeNowtPOIuvYRa25YCGB3b6
         PqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767652252; x=1768257052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5TSiCGHtgVwG4QGQWtbePwrqqtBM+EEwuz9E6PZ+cbA=;
        b=qgmUbThhBQ9cqUuURdHcDdW1X3yIYc0cv6A7kFlaCckJ5C7FmyU4uGu8gV3++y5oAd
         UvWU/THXs62EIhup+K08rqZPj0YopCgGsG2if+qa78PpXAP1R+klT/+B4pFZG3x1CWA8
         7sSRmtR6nJ93iUBT6jAneN8aR65RHygmxnLIKCBweAqF6A06E8KOMMIlHf68hUToU0nM
         K47mnytNKLYZEs9IEH3EtmigULcbi1zGXyCCS4Ccvfh7bwgvsGwwJiGZKH+RLCzse1iP
         cW2HjEhcFMKM0ePJhTzW1q7qJKLpWDnQWxQMyfrXapR8169tzWF5Saabh8WC05sokumz
         zmDA==
X-Forwarded-Encrypted: i=1; AJvYcCUTiNkD1nyNGK22zV4arMhmk21eymkaEWjetiXkBEBYmX5JHgjUX4qwyILAUO+Z0/GljCCYSzzul2mNSLif@vger.kernel.org
X-Gm-Message-State: AOJu0YysBBqw5yVgRztg/HQcZuDSopdWo3K5KtWB77kVzOhNirFtCfpa
	KF54E2mKin2bqj2+iUPzme08mg7jYfJFWKMcchMoMrGih5QVF4RjQ9hriuLcCyA8hFDMR93Scsj
	M2pEFqIPQKyYk+xmG+SxXzM4LD393YF4taZAsAuU=
X-Gm-Gg: AY/fxX6Jl7FqUqMXl07WHGCZ4Zy8l+K48RH+QlXeN4i691AkWh0lUvjYj6t4P0nunpY
	QQMi6dRtHxBSheWS6hq/Qm9/PKsMD+GcNpmXXQlfeJOg3u9CwubqmPCh77gEaru7MOS0kdeVREv
	S6BD3x+mmvOrU80yGvY2DobsAWmlQbPqaN+u8yn2/46epKg3RHDgGGTTO3sClaYVUY8Y6h/jn9C
	BoUbcGgUx9wM7Qftd14vIBYhjmhxO6Lj48utS74820pDeFhKKBlj7Hu0sODKZ38+VhY+w==
X-Google-Smtp-Source: AGHT+IF9DpYs7749/6gkNMdlDErzzYcJn1S0xwOYuM+fl7NM2pvZOJAurkuOaK85Qmm3ySVoe45Eh84qJBwtQwY2CFU=
X-Received: by 2002:ac8:7d8f:0:b0:4ee:197a:e80a with SMTP id
 d75a77b69052e-4ffa7843387mr16079941cf.77.1767652252124; Mon, 05 Jan 2026
 14:30:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223062113.52477-1-zhangtianci.1997@bytedance.com>
 <CAJnrk1aR=fPSXPuTBytnOPtE-0zuxfjMmFyug7fjsDa5T1djRA@mail.gmail.com>
 <CAP4dvsf+XGJQFk_UrGFmgTPfkbchm_izjO31M9rQN+wYU=8zMA@mail.gmail.com>
 <CAJnrk1Y0+j2xyko83s=b5Jw=maDKp3=HMYbLrVT5S+fJ1e2BNg@mail.gmail.com> <CAP4dvseWhaeu08NR-q=F5pRyMN5BnmWXHZi4i1L+utdjJTECaQ@mail.gmail.com>
In-Reply-To: <CAP4dvseWhaeu08NR-q=F5pRyMN5BnmWXHZi4i1L+utdjJTECaQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 5 Jan 2026 14:30:41 -0800
X-Gm-Features: AQt7F2oMKwiQv3sNIQlU4td8_0QR_Wk8Q_4qifm5wJGCPyOdvcTCk1fMYPl_Ud0
Message-ID: <CAJnrk1a2-HS6cqthfcU5hxBi7Rinwh8MpYggNtOg6P256aW0zw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: add hang check in request_wait_answer()
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xieyongji@bytedance.com, 
	zhujia.zj@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 11:22=E2=80=AFPM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> Hi Joanne, I apologize for the delayed response. Happy New Year!
Hi Tianci,

No worries at all, happy 2026!
>
> > That makes sense. In that case, I think it's cleaner to detect and
>
> > print the corresponding debug statements for this through libfuse
>
> > instead of the kernel.
>
> Yes, you're absolutely right. From the perspective of FUSEDaemon maintain=
ers,
> it is appropriate to place such checks in libfuse.
>
> However, from the viewpoint of personnel responsible for maintaining
> cluster kernel stability, they are more concerned with whether the
> kernel itself is affected.
>
> Additionally, if FUSEDaemon enters a state where it neither responds to k=
ernel
> FUSE requests nor can exit during the process exit phase due to certain b=
ugs
> (such as when FUSEDaemon incorrectly depends on the mount point it
> provides and thus enters a deadlock state), the alerts in libfuse will
> become ineffective.

imo it's possible to check whether the kernel itself is affected just
purely through libfuse changes to fuse_lowlevel.c where the request
communication with the kernel happens. The number of requests ready by
the kernel is exposed to userspace through sysfs, so if the daemon is
deadlocked or cannot read fuse requests, that scenario is detectable
by userspace.

Thanks,
Joanne

>
> Therefore, I think there is no need for an either-or choice between kerne=
l
> alerts and FUSEDaemon alerts.
>
> Thanks,
> Tianci

