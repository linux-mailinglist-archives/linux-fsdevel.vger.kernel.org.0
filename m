Return-Path: <linux-fsdevel+bounces-59179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387CBB3583F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 11:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5F77AC804
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 09:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A153302752;
	Tue, 26 Aug 2025 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaQMm1yq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451F2F60D8;
	Tue, 26 Aug 2025 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199464; cv=none; b=dZU7/mue3KA2Mj0jDj2nOaXxqqqx9eRPI/UN79KRrkzYrlkQT4RLHnyyAZZSBAi7OUnWcl4r7LvEzjf8aofF//5fM3szfWCvnJVdG734fkuNKGE51lz0/H5hFrr9RBwGJXQ0UeiKYls/nz0iKMhi6EAscAnbsbEcQykZvHclVLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199464; c=relaxed/simple;
	bh=59qoRxfQrxi6Exfr9j1Euyp1ZWsb1qo+I1L3mwtT02Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS1/aGr3aYTZ83X6fow+0Ffe4CeLKFloiC7DQADbk4ZvEQrgfzJDzet5BUacDU3zVnEY95aLHTZ4aBPzwXLCsygRyNdvqh8wDtAxHuwJeA7koXbTF11i0f1Xydu5wj1El0vOHvvQxk+rz2vstKX7f2Mey6mnSTtXFnPIN54xQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaQMm1yq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D025CC4CEF1;
	Tue, 26 Aug 2025 09:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756199464;
	bh=59qoRxfQrxi6Exfr9j1Euyp1ZWsb1qo+I1L3mwtT02Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LaQMm1yq25oNg00Tb0ywh3kNm1xatvEOLPlBbK0o1GwHHYqfPEVgmF+URx94vUrqR
	 QAUuFs4V9ldhlSPQfxTGQ8yAsjN6EndxgKl7c1LoB24sjj7rTEVwsBj2Z7WZ9bDw2y
	 PKgJF5IgwF1YEcukyj4pDfhWiLCGEVYuEHqHNCjpZ/oeWg2NA5jjkeg+Wi7sETgs4T
	 ux+wetmBVSWWET+iiiZwofCvFLsBiRVuDBgI80egsO11Ce3i/Cbp6MJb7CAGPhztek
	 H/8Ac/4yEid0G2mBNZPIF+UwSf/8i9CXk4+TQqsqgO8DqjBvmhtjJLSxJA6kAUeS1Q
	 E1g8lMgU7cCYA==
Date: Tue, 26 Aug 2025 11:10:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, Patrick Donnelly <pdonnell@redhat.com>, 
	Alex Markuze <amarkuze@redhat.com>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	Greg Farnum <gfarnum@ibm.com>
Subject: Re: [RFC] ceph: strange mount/unmount behavior
Message-ID: <20250826-bekommen-zugezogen-fed6b0e69be2@brauner>
References: <b803da9f0591b4f894f60906d7804a4181fd7455.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b803da9f0591b4f894f60906d7804a4181fd7455.camel@ibm.com>

On Mon, Aug 25, 2025 at 09:53:48PM +0000, Viacheslav Dubeyko wrote:
> Hello,
> 
> I am investigating an issue with generic/604:
> 
> sudo ./check generic/604
> FSTYP         -- ceph
> PLATFORM      -- Linux/x86_64 ceph-0005 6.17.0-rc1+ #29 SMP PREEMPT_DYNAMIC Mon
> Aug 25 13:06:10 PDT 2025
> MKFS_OPTIONS  -- 192.168.1.213:6789:/scratch
> MOUNT_OPTIONS -- -o name=admin 192.168.1.213:6789:/scratch /mnt/cephfs/scratch
> 
> generic/604 10s ... - output mismatch (see
> XFSTESTS/xfstestsdev/results//generic/604.out.bad)
>     --- tests/generic/604.out	2025-02-25 13:05:32.515668548 -0800
>     +++ XFSTESTS/xfstests-dev/results//generic/604.out.bad	2025-08-25
> 14:25:49.256780397 -0700
>     @@ -1,2 +1,3 @@
>      QA output created by 604
>     +umount: /mnt/cephfs/scratch: target is busy.
>      Silence is golden
>     ...
>     (Run 'diff -u XFSTESTS/xfstests-dev/tests/generic/604.out XFSTESTS/xfstests-
> dev/results//generic/604.out.bad'  to see the entire diff)
> Ran: generic/604
> Failures: generic/604
> Failed 1 of 1 tests
> 
> As far as I can see, the generic/604 intentionally delays the unmount and mount
> operation starts before unmount finish:
> 
> # For overlayfs, avoid unmounting the base fs after _scratch_mount tries to
> # mount the base fs.  Delay the mount attempt by a small amount in the hope
> # that the mount() call will try to lock s_umount /after/ umount has already
> # taken it.
> $UMOUNT_PROG $SCRATCH_MNT &
> sleep 0.01s ; _scratch_mount
> wait
> 
> As a result, we have this issue because a mnt_count is bigger than expected one
> in propagate_mount_busy() [1]:
> 
> 	} else {
> 		smp_mb(); // paired with __legitimize_mnt()
> 		shrink_submounts(mnt);
> 		retval = -EBUSY;
> 		if (!propagate_mount_busy(mnt, 2)) {
> 			umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
> 			retval = 0;
> 		}
> 	}
> 
> 
> [   71.347372] pid 3762 do_umount():2022 finished:  mnt_get_count(mnt) 3
> 
> But if I am trying to understand what is going on during mount, then I can see
> that I can mount the same file system instance multiple times even for the same
> mount point:

The new mount api has always allowed for this whereas the old mount(2)
api doesn't. There's no reason to not allow this.

