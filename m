Return-Path: <linux-fsdevel+bounces-54178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB21AFBCCC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1C81682D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD267220F57;
	Mon,  7 Jul 2025 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SFp8HQFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644853597A;
	Mon,  7 Jul 2025 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921362; cv=none; b=qDX7GBO2Opzx56jBjJdW8QQ7PQV9zT+xcVIBJGoferlRJmGM8kprRRm8+3U2nPyQzb2hFq7C6FGMBqniIp9+RwfoCy+ha7EIWEogy6iFw0dlJ48Lv2sapgERRdJvOvbipQfp2sVEWsvK64mhrT1wj1m1bjLB2Xvu3a/a02nIHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921362; c=relaxed/simple;
	bh=OPwYRsV2ja4jyraAWVchxj36SMa89ln97ao5fJsFkJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFRHmh2EeN4mHqM0Fy0Vdtl9s9DRh2xkX3zNEq2UnPLj1lLJ98JW4F+5UgSmIJPL52TWzBO9+Rbree4VlW4U1IyRdrcf1pvoYScmyIsr5/OLU9I9CwLR+3wCW+bL4RT0F/DPt4W2bWgGzwYy/hEkCzv+nROPRP6dk9NGNBHV+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SFp8HQFZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g0QMBx8KfGZY6hoKAphVq9VC9pOgKSRRzHza0BduFT8=; b=SFp8HQFZS9B6BcK7cJRTTGidpl
	2yXK35INgDDJW82fCJRD5mNHWCUCOnHkZYmGyLfVMplP0dNWjjW2d3ld+FJ1u25gTTYATnUEyxQ+c
	HM5BHMx+PD1D/56MBBCe1/ZbcONdRV3XqyyQTfzDrpVAe8o4uWLq5+c1m36LID9Vt/Vkn/6y0bjqe
	Wn8N9b0+OxF+bozpsBPnRXUg/8HZwTz/Tm9Qkfo+0Jk92bOs5BDkHKKEbNxinHXDWncPdO7fEonDz
	5OsF0SG45UiFFw99ftjXlJyUxLv9zvhV1wW8h414N0mC5qOOcWeosShyv6U4Y5UTLrbiEbNWYkM8v
	0ivzN53w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYsm6-00000003jOm-34RN;
	Mon, 07 Jul 2025 20:49:18 +0000
Date: Mon, 7 Jul 2025 21:49:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
Message-ID: <20250707204918.GK1880847@ZenIV>
References: <20231124060422.576198-20-viro@zeniv.linux.org.uk>
 <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
 <20250707172956.GF1880847@ZenIV>
 <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
 <20250707180026.GG1880847@ZenIV>
 <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
 <20250707193115.GH1880847@ZenIV>
 <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
 <20250707203104.GJ1880847@ZenIV>
 <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 10:39:27PM +0200, Max Kellermann wrote:
> > Busy loop here means that everything in the tree is either busy or already
> > in process of being torn down *by* *another* *thread*.  And that's already
> > in process - not just selected for it (see collect2 in the same loop).
> 
> The busy process isn't doing anything. All it does is busy-wait for
> another task to complete the evict() call. A pointless waste of CPU
> cycles.
> 
> > The interesting question is what the other thread is doing...
> 
> ceph_evict_inode() is waiting for the Ceph server to acknowledge a
> pending I/O operation.

Yes, but where does that ceph_evict_inode() come from?  What's in its call chain?
Is it several shrink_dcache_parent() fighting each other on the same tree, or...?

