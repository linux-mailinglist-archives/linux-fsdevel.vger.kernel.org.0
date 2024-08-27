Return-Path: <linux-fsdevel+bounces-27403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287349613D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593F31C23474
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95371C9EC9;
	Tue, 27 Aug 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VkQyER4q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360C51C8700
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775441; cv=none; b=Xzt6ZuTzoc6Ggesxz08C1SrdGp5iLvjKqLV3uU3vD7aD8TtwZNXdUru2Q+FjimrB17PDnhSbAvh9WBa+unIEORZAXjRq8EnFutEbtvUns3ajxizVqsO905anGZR2brvmmsGE+T7t3zqoy27BHozm8ON82YTH/SY2Xh9vzpZD5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775441; c=relaxed/simple;
	bh=dRGDAD4KPiBqXOmNHPLfWVDiOw++ZqkdXmPpkSUphBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhsnfeYypdAyl8oWxg5ITjXE6/+ZTsfu2MruThgtbd4bsIzoKvJnmsMYsK4Jsgu33eDlt1fGor9Y1JD7foC9FHyA1rcZxwcn/v97S8y548Ik/gweLH2NWdOCNiIzHGJoW9Kx0AF8shyMSJEmSPEG6CauNkdwlV5LNRrN+GHR9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VkQyER4q; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Aug 2024 12:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724775435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DqMw3wLXUFrALSOq/FX1urjPjZInRQbR39RoFjtaExE=;
	b=VkQyER4qXTqPpQOn1oyO9kEQvvT+Ngr1fA7Aiegk/hJZOa3sHjTuwR/EseY6pwIrg0reVF
	sUbo0piwMGSqat2njA5MTSIfPa7CQhw0g6VOjLDprgtkdKbKqXQB9Oxt39v4IBEuZoz0X7
	6g+nuJuRUUoFDqT2lTNi837W5CQLCHg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Wang <00107082@163.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [BUG?] bcachefs: keep writing to device when there is no
 high-level I/O activity.
Message-ID: <y336p7vehwl6rpi5lfht6znaosnaqk3tvigzxcda7oi6ukk3o4@p4imj4wzcxjb>
References: <20240827094933.6363-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827094933.6363-1-00107082@163.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 27, 2024 at 05:49:33PM GMT, David Wang wrote:
> Hi,
> 
> I was using two partitions on same nvme device to compare filesystem performance,
> and I consistantly observed a strange behavior:
> 
> After 10 minutes fio test with bcachefs on one partition, performance degrade
> significantly for other filesystems on other partition (same device).
> 
> 	ext4  150M/s --> 143M/s
> 	xfs   150M/s --> 134M/s
> 	btrfs 127M/s --> 108M/s
> 
> Several round tests show the same pattern that bcachefs seems occupy some device resource
> even when there is no high-level I/O.

This is is a known issue, it should be either journal reclaim or
rebalance.

(We could use some better stats to see exactly which it is)

The algorithm for how we do background work needs to change; I've
written up a new one but I'm a ways off from having time to implement it

https://evilpiepirate.org/git/bcachefs.git/commit/?h=bcachefs-garbage&id=47a4b574fb420aa824aad222436f4c294daf66ae

Could be a fun one for someone new to take on.

> 
> I monitor /proc/diskstats, and it confirmed that bcachefs do keep writing the device.
> Following is the time serial samples for "writes_completed" on my bcachefs partition:
> 
> writes_completed @timestamp
> 	       0 @1724748233.712
> 	       4 @1724748248.712    <--- mkfs
> 	       4 @1724748263.712
> 	      65 @1724748278.712
> 	   25350 @1724748293.712
> 	   63839 @1724748308.712    <--- fio started
>   	  352228 @1724748323.712
> 	  621350 @1724748338.712
> 	  903487 @1724748353.712
>         ...
> 	12790311 @1724748863.712
> 	13100041 @1724748878.712
> 	13419642 @1724748893.712
> 	13701685 @1724748908.712    <--- fio done (10minutes)
> 	13701769 @1724748923.712    <--- from here, average 5~7writes/second for 2000 seconds
> 	13701852 @1724748938.712
> 	13701953 @1724748953.712
> 	13702032 @1724748968.712
> 	13702133 @1724748983.712
> 	13702213 @1724748998.712
> 	13702265 @1724749013.712
> 	13702357 @1724749028.712
>         ...
> 	13712984 @1724750858.712
> 	13713076 @1724750873.712
> 	13713196 @1724750888.712
> 	13713299 @1724750903.712
> 	13713386 @1724750918.712
> 	13713463 @1724750933.712
> 	13713501 @1724750948.712   <--- writes stopped here
> 	13713501 @1724750963.712
> 	13713501 @1724750978.712
> 	...
> 
> Is this behavior expected? 
> 
> My test script:
> 	set -e
> 	for fsa in "btrfs" "ext4" "bcachefs" "xfs"
> 	do
> 		if [ $fsa == 'ext4' ]; then
> 			mkfs -t ext4 -F /dev/nvme0n1p1
> 		else
> 			mkfs -t $fsa -f /dev/nvme0n1p1
> 		fi
> 		mount -t $fsa /dev/nvme0n1p1 /disk02/dir1
> 		for fsb in "ext4" "bcachefs" "xfs" "btrfs"
> 		do
> 			if [ $fsb == 'ext4' ]; then
> 				mkfs -t ext4 -F /dev/nvme0n1p2
> 			else
> 				mkfs -t $fsb -f /dev/nvme0n1p2
> 			fi
> 			mount -t $fsb /dev/nvme0n1p2 /disk02/dir2
> 
> 			cd /disk02/dir1 && fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test  --bs=4k --iodepth=64 --size=1G --readwrite=randrw  --runtime=600 --numjobs=8 --time_based=1 --output=/disk02/fio.${fsa}.${fsb}.0
> 			sleep 30
> 			cd /disk02/dir2 && fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test  --bs=4k --iodepth=64 --size=1G --readwrite=randrw  --runtime=600 --numjobs=8 --time_based=1 --output=/disk02/fio.${fsa}.${fsb}.1
> 			sleep 30
> 			cd /disk02
> 			umount /disk02/dir2
> 		done
> 		umount /disk02/dir1
> 	done
> 
> And here is a report for one round of test matrix:
> +----------+-----------------------------+-----------------------------+-----------------------------+-----------------------------+
> |   R|W    |             ext4            |           bcachefs          |             xfs             |            btrfs            |
> +----------+-----------------------------+-----------------------------+-----------------------------+-----------------------------+
> |   ext4   |    [ext4]147MB/s|147MB/s    |    [ext4]146MB/s|146MB/s    |    [ext4]150MB/s|150MB/s    |    [ext4]149MB/s|149MB/s    |
> |          |    [ext4]146MB/s|146MB/s    | [bcachefs]72.2MB/s|72.2MB/s |     [xfs]149MB/s|149MB/s    |    [btrfs]132MB/s|132MB/s   |
> | bcachefs | [bcachefs]71.9MB/s|71.9MB/s | [bcachefs]65.1MB/s|65.1MB/s | [bcachefs]69.6MB/s|69.6MB/s | [bcachefs]65.8MB/s|65.8MB/s |
> |          |    [ext4]143MB/s|143MB/s    | [bcachefs]71.5MB/s|71.5MB/s |     [xfs]134MB/s|133MB/s    |    [btrfs]108MB/s|108MB/s   |
> |   xfs    |     [xfs]148MB/s|148MB/s    |     [xfs]147MB/s|147MB/s    |     [xfs]152MB/s|152MB/s    |     [xfs]151MB/s|151MB/s    |
> |          |    [ext4]147MB/s|147MB/s    | [bcachefs]71.3MB/s|71.3MB/s |     [xfs]148MB/s|148MB/s    |    [btrfs]127MB/s|127MB/s   |
> |  btrfs   |    [btrfs]132MB/s|132MB/s   |    [btrfs]112MB/s|111MB/s   |    [btrfs]110MB/s|110MB/s   |    [btrfs]110MB/s|110MB/s   |
> |          |    [ext4]147MB/s|146MB/s    | [bcachefs]69.7MB/s|69.7MB/s |     [xfs]146MB/s|146MB/s    |    [btrfs]125MB/s|125MB/s   |
> +----------+-----------------------------+-----------------------------+-----------------------------+-----------------------------+
> (The rows are for the FS on the first partition, and the cols are on the second partition)
> 
> The version of bcachefs-tools on my system is 1.9.1.
> (The impact is worse, ext4 dropped to 80M/s, when I was using bcachefs-tools from debian repos which is too *old*,
> and known to cause bcachefs problems. And that is the reason that I do this kind of test.)
> 
> 
> Thanks
> David
> 

