Return-Path: <linux-fsdevel+bounces-53738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5421AF650C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 00:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCCC3A8674
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 22:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3CB242D6B;
	Wed,  2 Jul 2025 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvSFYJO+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570582DE718
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751494803; cv=none; b=rvpG6ZbmIrNMNQYSFytMJi9f4N2EHGXF82v8ZNEXUBcVXYqIRFHZJBTaKml1AGBZzwVPp+bidJe87zhEUSj+ORnALmcEX+/YF81yn6XzNo+iCzNsQ2OETNqomnQm+9avmxbEt/xZvIbMj5JXfgJhGC8MMcwFXOVZAlEfch87VfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751494803; c=relaxed/simple;
	bh=s1kJC27xSojl53YMJYuiMKdzdUsNH/EGM/6a1+RM+xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlG2ldTrRfH/OwQTM+NfoyJGmeSWXvcHNOQR2jrz0Bwf5KkL1eJ3ftffXhj2R5yAmJgfmQnkHUnkSaALu4Wxw22dIF5ZaiFFO78XeTm/1J0xvbT64BR6kx+wqYXBlDRFPqGA3+1ATm6vMULNC4jC3mim+9OuRf0FzDwFeh+ayyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvSFYJO+; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a7f46f9bb6so66109741cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751494800; x=1752099600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1kJC27xSojl53YMJYuiMKdzdUsNH/EGM/6a1+RM+xU=;
        b=dvSFYJO+JiIUwMbCD177stQX2j73p4PKYVXeewQnbIXFBgLvnWSxerFtZ07gfu1krR
         aS2VbNIRjQtQY3FnKWOY0ywry3z7FDekXlUBUKaSk9T2tI3SjpYPDNynJX2i/VJ5YXy7
         Hywn+L6DjT/Ha3AIGFDMFFu83RY+oCqDWVvY8s4K5WQgnKe8NsX5kGf2NJBo+16iyHuW
         yib7rvzh4vujcmBxdJxMAnNZeHl9QKLSa82uMfDCEDH7HRZR8P73Ys1DYsnCJVLiK6Pv
         RoMAQHGvBR9FAHt43eflLwAVrWjLxNEiYGBjLP+m1/po3G02zWG6f4xcU5LfSfX5yHMQ
         VAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751494800; x=1752099600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1kJC27xSojl53YMJYuiMKdzdUsNH/EGM/6a1+RM+xU=;
        b=cZ1c9SHJNvwXwdrfao7YSbOGYeJv/mc774wOwdm2GJawb1pxiUPy6r+AbNwb7LMIu/
         kpJHeHXk8//GW2oXtclU+oTbGNtCN/O/V6CvoQf1nvweqBRlBv21z9tyFC7rqS4JdGMV
         iPrzNF/W41MNzGqVspQkffREV5+rsSKneq4PUxns68yvM36Kx41semnPO4DGaiqWWF3E
         cF9PC+l9A6ppdtwI0Z3rG7l3jZzL2gvfdPiiMMRjSdHsLjEHcDfIrxJdl79Ph4XSZyMc
         K319ZbFCyjwbC26kQM9joh4SvQ0XaSdbkf7hIHXlmhopxlZJit90svlRQFIiRQUfT59o
         xagA==
X-Gm-Message-State: AOJu0Yw3Xv2PvO/h5TSpJ0MsALh32SVUVnR8tvbSsVMZolRF+uAt1QOA
	mJ6uVD+xzgBiafovUq7DIRKvQEgoe42MIEwZ7inRj8kmpSBYgjUFCluK7rVZlydEN8Y508aG+an
	4iG44og7+YFOhzoqxX6utZWhR7OUofhk=
X-Gm-Gg: ASbGncuEi+hosVvhGhvNnd5my5jYPTIG8gGM+HU2skiLB7IME0tdP29jO5j5cDtn3fc
	Rx5FG4d5BeWzO9pmkBmU/1jjfttYjC2YsTv0yicpLWFBJYxRXiDrbXnHExOreKUbS2rT8HVRwWy
	auLkMr4JR2oF5+E33BcJ1PDZv5nGKwtA2KG2Ylm+hw2a7aeJyPplQaE7h/HdQ=
X-Google-Smtp-Source: AGHT+IEqSroXHEe+QzVCxkvIVuli9xX6HZVsDaC/Km/v2PVnrPXaMQCYngDo1BwC2qVyQvb29fz/F9BgU/v0EqFcLm4=
X-Received: by 2002:a05:622a:5b92:b0:494:993d:ec30 with SMTP id
 d75a77b69052e-4a9768f256fmr76533251cf.16.1751494800083; Wed, 02 Jul 2025
 15:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523181604.3939656-1-joannelkoong@gmail.com>
 <20250523181604.3939656-2-joannelkoong@gmail.com> <CAJfpegudqgztbQb1z1c9TKhvdAz1usspVi1Cx3qFOj_RjSb=vw@mail.gmail.com>
In-Reply-To: <CAJfpegudqgztbQb1z1c9TKhvdAz1usspVi1Cx3qFOj_RjSb=vw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 2 Jul 2025 15:19:49 -0700
X-Gm-Features: Ac12FXzfZMAgYDGlAq_bEmnpbMxattXHsbmHmVUmKrrQTD5CkbO59nvPxiYem8M
Message-ID: <CAJnrk1bJm7oAU-vr=ySzf8c2SmBDFZ94Lr-BU110tVqx+xFxcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: clean up null folio check in fuse_copy_folio()
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 10:34=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 23 May 2025 at 20:18, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> >
> > In fuse_copy_folio(), the folio in *foliop will never be null.
> > fuse_copy_folio() is called from two places, fuse_copy_folios() and
> > fuse_notify_store(). In fuse_copy_folios(), the folio will never be nul=
l
> > since ap->num_folios always reflects how many folios are stored in the
> > ap->folios[] array.
>
> Hmm, well, did you verify that none of the callers leave any holes?
> ISTR there was a reason to put the NULL check in there, I just don't
> remember what that reason was.

I audited the places where ap->num_folios gets set or incremented and
didn't see any place where there wasn't also an
ap->folios[ap->num_folios] assignment preceding it.

I'm fine with dropping this patch if you would rather the NULL check
be left in there.

Thanks,
Joanne

>
> Thanks,
> Miklos

