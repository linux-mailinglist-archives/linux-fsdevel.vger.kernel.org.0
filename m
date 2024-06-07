Return-Path: <linux-fsdevel+bounces-21265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18859900A0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 18:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275181C23480
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D237419AA68;
	Fri,  7 Jun 2024 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPq51zot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1519A2A8
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776503; cv=none; b=NlwrCZSq+GxWyqQXYj6KG7ToLOGVNHtiAe+Rsldg5PBAix+oACeWMGWrE6YQ7T1EHQdQvKPYXJzTbVPYddXqvhmIaoYwLcIVsl+RVxGmluFzRgsknd5RQfdumuc5ASlZA/tj8eDy8WQ8cOcZd9kg8rjrHss3FWm3JOLx6G+TKnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776503; c=relaxed/simple;
	bh=/bCRw9V9smy8/OqTMhKseNfEQPrIwyNcmbXAjscjfWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlaRfLOn4cOxwXGFsQxAZxzFJ5/+/Rjj0ibWR0d0q2lWFk4Q/vvrG7OEW73O86EG50fejfSWLrBdwt6BLe7I4ffaTRlJ/St/ifkvPxBPSc/J+F4WuHZyIW8XCyIlN4UCphufHV7lstvovAIEiAGA2BD2dwfoOpw1lygka9wMkyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPq51zot; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35ef3a037a0so1341434f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jun 2024 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717776500; x=1718381300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1FiQmA3h9bAoeVUDfPcvgNd7biTjh4clBKXh1L64sw=;
        b=KPq51zotllX830khqfxXM0we2PYOX68dHsruDCZPj5gqfJEjR23LAjRCOPBBaffsAL
         XEL4OoUUJoo7Cw5Cf8874RD6GP+WLheoo6TmV6Hj9hx7LgghEDXdk4nU9OkF0ocS3cvu
         cqB2N4v6JfHgyCA4jY/fgDdAn1TWLm2h6gr0mFlwafh6kQf7ogZfQqICSv/xwC1jt4Vy
         zQJWjGO2k8JT2WT8zNznDhjXnJNLIFq2vyl4HNLNeZQOE4a+L2YNNFO36ZS4wUaLMLmC
         8+g7XNhYDkH/CvoPZbJOyOLDAkPk5flKfQ+aVBciy1q/SllkRxkRXU7h+SuHXG2R+bTT
         SYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776500; x=1718381300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1FiQmA3h9bAoeVUDfPcvgNd7biTjh4clBKXh1L64sw=;
        b=hRhheVCfixKHP5Bf87e1KvDuLgULlTenF3X6AmYN+eQS4aH0GikQmUMsO0YZ160EIS
         K5dZwLdMCXudUbKFClcE2BUe1rGxy4e71TQ47y9mLbdw1xQYDiA4uWstGvaIhxl9PzOO
         WVTWpR15CzwWp3s6hO6al64bKsE6A64VQzsnaodCFPubyWHtfSDlvzP/QvhqCl92jZ6w
         fpo7Ha9MbAwRHMH29Ujkof4p2hqeNHvoGr/LrhTP1aFhm+XZHOw/YXRWk2mSUmTvm2tA
         Gjgp1DnALNXgDSfi2jmXGVvpi3LbyUUQ7LOGnFdo4YwoQdtrQ+bafgfiP4JIGswygFfu
         DT2Q==
X-Gm-Message-State: AOJu0YyEnQ3wt0GVMGZKSNG7ODC998cjDQzaCy/kmNlIQWvtKFFI1hBk
	Gz49AENWNGdSJ12Yn0n4zXxoAXNhL7U1VFP0VXpvM/T0yCmOF9y2
X-Google-Smtp-Source: AGHT+IGaMfSAVoh71ioPuD4fDzahhAuu2LpDnC9h9YteaRTXfUenUpXI+Tn+Z8IQ/L5uTb/aen/3Qw==
X-Received: by 2002:a5d:420b:0:b0:35f:d6f:aa91 with SMTP id ffacd0b85a97d-35f0d6fae44mr995920f8f.9.1717776499588;
        Fri, 07 Jun 2024 09:08:19 -0700 (PDT)
Received: from f (cst-prg-24-228.cust.vodafone.cz. [46.135.24.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d4729asm4273769f8f.25.2024.06.07.09.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:08:19 -0700 (PDT)
Date: Fri, 7 Jun 2024 18:08:12 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 0/4] fs: allow listmount() with reversed ordering
Message-ID: <efwzpd2qlelhxiulf2bp6ygo5u3xlz6swhwuiax6fjrsyc5g4h@oj2tw4d4hwmk>
References: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>

On Fri, Jun 07, 2024 at 04:55:33PM +0200, Christian Brauner wrote:
> util-linux is about to implement listmount() and statmount() support.
> Karel requested the ability to scan the mount table in backwards order
> because that's what libmount currently does in order to get the latest
> mount first. We currently don't support this in listmount(). Add a new
> LISTMOUNT_RESERVE flag to allow listing mounts in reverse order. For
> example, listing all child mounts of /sys without LISTMOUNT_REVERSE
> gives:
> 
>     /sys/kernel/security @ mnt_id: 4294968369
>     /sys/fs/cgroup @ mnt_id: 4294968370
>     /sys/firmware/efi/efivars @ mnt_id: 4294968371
>     /sys/fs/bpf @ mnt_id: 4294968372
>     /sys/kernel/tracing @ mnt_id: 4294968373
>     /sys/kernel/debug @ mnt_id: 4294968374
>     /sys/fs/fuse/connections @ mnt_id: 4294968375
>     /sys/kernel/config @ mnt_id: 4294968376
> 
> whereas with LISTMOUNT_RESERVE it gives:
> 
>     /sys/kernel/config @ mnt_id: 4294968376
>     /sys/fs/fuse/connections @ mnt_id: 4294968375
>     /sys/kernel/debug @ mnt_id: 4294968374
>     /sys/kernel/tracing @ mnt_id: 4294968373
>     /sys/fs/bpf @ mnt_id: 4294968372
>     /sys/firmware/efi/efivars @ mnt_id: 4294968371
>     /sys/fs/cgroup @ mnt_id: 4294968370
>     /sys/kernel/security @ mnt_id: 4294968369
> 
> A few smaller cleanups included in this series.
> 

I have some remarks about listmount, they are not patchset-specific
though.

If I'm reading things correctly put_user is performed with namespace_sem
held? While it probably works, it is fundamentally unsound behavior --
said put_user introduces funky lock orderings which don't need to be
there and can go off cpu indefinitely waiting for the fault to be
serviced.

Either the code needs to pre-wire user memory or it needs to export to
userspace in chunks while dropping the lock in-between (say 16 or
whatever IDs per batch, something stack-tolerable).

From cursory reading dropping the lock looks fine.

This has no bearing on the feature, but since you are cleaning up the
syscall apart from it perhaps you will be willing to sort this out.

Bonus question is why lockdep is not yelling about it. At best only
select locks should be allowed to take a page fault with.

