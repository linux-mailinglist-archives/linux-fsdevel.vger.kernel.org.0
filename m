Return-Path: <linux-fsdevel+bounces-62024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D53FAB81E54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 151C37B4F41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2972F5A24;
	Wed, 17 Sep 2025 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="C8jYwmOY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2422F2604;
	Wed, 17 Sep 2025 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143413; cv=none; b=Wl2NwWyB/9lOrag18CY5kJreB1IVAsSr/1yAv/RUNA+R0Mip9HWDLZDUbZykZsQ9Dw0bhOKB9B5u8efmfvlKyYdcGYC3YgSK+6FUjB+T3UxGvG+mWwb67jM5JINHNFdBULReYRbCeP/xmIXvSt2OSG/VAaQ0nV+StquzBH47Cns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143413; c=relaxed/simple;
	bh=2vIOMdy4Vj9yN8eIvTrykpOLQsfLeeAOAEeq7Z/Fd7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrAdmhijGhkbyCJRAYCS3VeHrd96cf4U6KJPf9yHqkoMXfkOVC3VbmgbvhM1wKXywdqpxCngjUsl6CzQRCRFAUa1gX7F7hhEJqugjCmL6zw6oIV/FnXYqlog/xsEvVilkrP0mrCXUCu+ppz3h5aJ5SXHaPF0WfdTj7xwzK4o0RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=C8jYwmOY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=4zCJt6toGovk2j2NYp2jgoQbUCVgHY4TcWg2PTIc63E=; b=C8jYwmOYevWbVc6pf7aTmx8bBK
	ZKVs/QU3wTUQhsll2PGahlaXKDvDiZjDPuBKP+nl2ilLTquFNbNkaBwA7l6y7kD0pRBCEKgu17Z9c
	Zj/WuauoJxZrG+v+0RkolMxZb0YzY4BtuoiLaMieXsVhnTfO2nvmCwyg4QaG3lMFkkUf+K+bNOBdo
	gb4pt2DK+NkKXEBPGrnIgzEeHid/W12ivCUcnXuZn/wDnQiP8Uzpm566RJcZjwjsJFj+EVCGmv+be
	lEp4cjlG/tAQIj6pbYOymDA2XQWSsfyXgBkFWYp0UT7LpYvtNY+vz5GCSqsQLmIsPgIyVEucMogS9
	zJhAVV+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyzPl-00000008YoM-1TR8;
	Wed, 17 Sep 2025 21:10:09 +0000
Date: Wed, 17 Sep 2025 22:10:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	ceph-devel@vger.kernel.org
Subject: Re: Need advice with iput() deadlock during writeback
Message-ID: <20250917211009.GE39973@ZenIV>
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
 <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
 <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com>
 <20250917201408.GX39973@ZenIV>
 <CAGudoHFEE4nS_cWuc3xjmP=OaQSXMCg0eBrKCBHc3tf104er3A@mail.gmail.com>
 <20250917203435.GA39973@ZenIV>
 <CAKPOu+8wLezQY05ZLSd4P2OySe7qqE7CTHzYG6pobpt=xV--Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+8wLezQY05ZLSd4P2OySe7qqE7CTHzYG6pobpt=xV--Jg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 17, 2025 at 10:36:48PM +0200, Max Kellermann wrote:
> On Wed, Sep 17, 2025 at 10:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > Suppose two threads do umount() on two different filesystems.  The first
> > one to flush picks *everything* you've delayed and starts handling that.
> > The second sees nothing to do and proceeds to taking the filesystem
> > it's unmounting apart, right under the nose of the first thread doing
> > work on both filesystems...
> 
> Each filesystem (struct ceph_fs_client) has its own inode_wq.

Yes, but
	 if (llist_add(&ci->async_llist, &delayed_ceph_iput_list))                                                               
		 schedule_delayed_work(&delayed_ceph_iput_work, 1);                                                              
won't have anything to do with that.

