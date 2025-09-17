Return-Path: <linux-fsdevel+bounces-62007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC29B81BBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D40346706B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F166F29E0E6;
	Wed, 17 Sep 2025 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TH1QaPv1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83465279789;
	Wed, 17 Sep 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140054; cv=none; b=lU6UiDgS035K3x4g9iAYxijd5wVeU8qOlh9C6nJ+9ijvcrbqEpHq1SCXBbi2Fnkj8xhB3IbBNMI2Zlp6Bv9E3vSQM4u3UUlFjj2shx/dmC7dXwO09FvQPiiKQvArN+1JUgPdprw/4JyAD2mUBok/Y4IdVKzBTRIh+3bQaudTZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140054; c=relaxed/simple;
	bh=TBWmO7qDtz2VPnXLT/2eD43MfyOKUOuvUK8rcXc2gV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtbcVHvEV/L6prkh40lu7IDKWmcaNESOdJIpotWYO2MDzXkcvT7JzeK5zO/21iBEpl3jyRO+YBwCN8fF88AQAiet2byaEcGFJlzV+9aOyFH7dC59HVU0nA2VTKGAi3F3tFUnvnEpKMD7384n5NPWU8t6d3HIlRx4N2tMyc1q7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TH1QaPv1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QfpCzaT2p4iQp70qcwxepldsjgNkeN5UhrG79FYYO3s=; b=TH1QaPv1dzyQ1aS63yfbSauS6s
	/14Z4rgs6HB4WMQvJBLH7sQc/88GK5sBKUlXNSkd5BcdixV+ZooCpi0mQ8hXW22jGL5eCjuLGC6WJ
	z6UdSRiJzFQhOfQm5klQckGM/rq4RFEkWb+LGUGMJY86Qk1YyGwuPl+Xf02ve+CRXG94gEbEOVk02
	o3mlYs2Ke3JHDBnuJTmbghJl0QVX4tSLqdGbMSzznAh52RpRoIk/wr5ClsMYNzCNmR/yslNWbazGp
	t2F8zqY2j5ITvcVB8L79azP8kzZrmsoB+/lg1rNBRwbJH8tHuxhOAsN+pqhibTX738eFqAermHeqd
	Yv/K/iew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyyXY-00000007ZWo-2zlc;
	Wed, 17 Sep 2025 20:14:08 +0000
Date: Wed, 17 Sep 2025 21:14:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Max Kellermann <max.kellermann@ionos.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	ceph-devel@vger.kernel.org
Subject: Re: Need advice with iput() deadlock during writeback
Message-ID: <20250917201408.GX39973@ZenIV>
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
 <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
 <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 17, 2025 at 10:59:23AM +0200, Mateusz Guzik wrote:

> A sketch, incomplete:
> static DECLARE_DELAYED_WORK(delayed_ceph_iput_work, delayed_ceph_iput);
> 
> static void __ceph_iput_async(struct callback_head *work)
> {
>         struct ceph_inode_info *ci = container_of(work, struct
> ceph_inode_info, async_task_work);
>         iput(&ci->netfs.inode);
> }
> 
> void ceph_iput_async(struct ceph_inode_info *ci)
> {
>         struct inode *inode = &ci->netfs.inode;
> 
>         if (atomic_add_unless(&inode->i_count, -1, 1))
>                 return;
> 
>         if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
>                 init_task_work(&ci->async_task_work, __ceph_iput_async);
>                 if (!task_work_add(task, &ci->async_task_work, TWA_RESUME))
>                         return;
>         }
> 
>         if (llist_add(&ci->async_llist, &delayed_ceph_iput_list))
>                 schedule_delayed_work(&delayed_ceph_iput_work, 1);
> }

Looks rather dangerous - what do you do on fs shutdown?

