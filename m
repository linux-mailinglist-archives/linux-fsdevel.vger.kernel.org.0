Return-Path: <linux-fsdevel+bounces-60283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8612AB440A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BAF171517
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 15:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEBA23A984;
	Thu,  4 Sep 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="peAXYNWV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB29A29B0;
	Thu,  4 Sep 2025 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999856; cv=none; b=OnoJs930DkNVJMXwJOADWfCk0ph3J+JVSG7v8WmGJazLI5dewJZ2tMKGxm0gQLg7aZyJAbaiKsoEYAHYf2M4R2OBG/DKZwLGp5graUVZ78D91TvTNIQYwJjYu3CLBFbujx2zBjNTQ4VXtcoOFRk/U9t4EXUNW3XKmhtriuhIaHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999856; c=relaxed/simple;
	bh=JhYCaBsL4NKONs5qmawgoRSrH8rLxwFwv15ef/JwF0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PuLwrc7riYx6rkftzwHH0Z8IX54WGsTHAQakwitdj6mtsddZP/C+E4ogtc6A/nZcvqM4dBWlKB3Fr1YRwuzUt+ZtPhw+4+REIA/MDhEvOzGune5rCTwQ5Ye7FBkosU71TnbxBRmUyQ5cymkyI+wogewH2UCaOKBgJ1zofxzj//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=peAXYNWV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=r2lDA56QzbhbJ8oWUFk+wNSPKJeXt97a/UhcW2yZe64=; b=peAXYNWVMyQVD9/Y6NRF2oBJ8y
	cmt5hlFkZG92xu38TQj8+t/hsMRCJUe5Z6AOYO3nmB/uYrvhUlU9QdRmhGE3GZ//Fk+aBe8hvIu5H
	vtrN7qIYaO7mzgIM6Qu2SJs9P+uI/Q8pHI2C8E2VdgBKfot54pE9KaXDaWis5TkDzhYkRzE6blvFm
	nSqVb0Pyard2YrytK1t631QP+bDV4DldltC3gfjw93CGc4klpeAk3GL5F30J6jEPch7Cw4As1QpnT
	/kuvoESVbUL87AIUvpvwp5B1Qx2SQ6AQfP5AGlCTjZS/Bg44nsJkyNR7GFe/vkqAEgl/VLWdREKc1
	LmgPOwIw==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uuBvA-006ras-Nm; Thu, 04 Sep 2025 17:30:44 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Laura Promberger
 <laura.promberger@cern.ch>,  Dave Chinner <david@fromorbit.com>,  Matt
 Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  kernel-dev@igalia.com,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/2] fuse: new work queue to periodically
 invalidate expired dentries
In-Reply-To: <CAJfpeguPytg1b4k3jRuCHzXMUbwh6AT3Q4rptnVoRrHOA0PHMA@mail.gmail.com>
	(Miklos Szeredi's message of "Thu, 4 Sep 2025 17:12:21 +0200")
References: <20250828162951.60437-1-luis@igalia.com>
	<20250828162951.60437-2-luis@igalia.com>
	<CAJfpegtfeCJgzSLOYABTaZ7Hec6JDMHpQtxDzg61jAPJcRZQZA@mail.gmail.com>
	<87y0qul3mb.fsf@wotan.olymp>
	<CAJfpeguPytg1b4k3jRuCHzXMUbwh6AT3Q4rptnVoRrHOA0PHMA@mail.gmail.com>
Date: Thu, 04 Sep 2025 16:30:44 +0100
Message-ID: <87ldmukzff.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04 2025, Miklos Szeredi wrote:

> On Thu, 4 Sept 2025 at 16:00, Luis Henriques <luis@igalia.com> wrote:
>>
>> Hi Miklos,
>>
>> On Thu, Sep 04 2025, Miklos Szeredi wrote:
>>
>> > On Thu, 28 Aug 2025 at 18:30, Luis Henriques <luis@igalia.com> wrote:
>
>> >> +       if (!inval_wq && RB_EMPTY_NODE(&fd->node))
>> >> +               return;
>> >
>> > inval_wq can change to zero, which shouldn't prevent removing from the=
 rbtree.
>>
>> Maybe I didn't understood your comment, but isn't that what's happening
>> here?  If the 'fd' is in a tree, it will be removed, independently of the
>> 'inval_wq' value.
>
> I somehow thought it was || not &&.
>
> But I still don't see the point.  The only caller already checked
> RB_EMPTY_NODE, so that is false. No race possible since it's called
> form the destruction of the dentry, and so this expression is
> guaranteed to evaluate to false.

Fair enough.  I'll drop that code.

>> (By the way, I considered using mutexes here instead.  Do you have any
>> thoughts on this?)
>
> Use mutex where protected code might sleep, spin lock otherwise.
>
>>
>> What I don't understand in your comment is where you suggest these helpe=
rs
>> could be in a higher level.  Could you elaborate on what exactly you have
>> in mind?
>
> E.g.
>
> void d_dispose_if_unused(struct dentry *dentry, struct list_head *dispose)
> {
>         spin_lock(&dentry->d_lock);
>         if (!dentry->d_lockref.count)
>                 to_shrink_list(dentry, dispose);
>         spin_unlock(&dentry->d_lock);
> }
>
> Which is in fact taken from d_prune_aliases(), which could be modified
> to use this helper.

Oh! OK, got it.  Thanks, I'll start working on v6 and try to include all
your suggestions.

Cheers,
--=20
Lu=C3=ADs

