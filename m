Return-Path: <linux-fsdevel+bounces-25078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E21948B6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3F1285E02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF951BD01F;
	Tue,  6 Aug 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="MlaUS+f9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001DE16C692
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933474; cv=none; b=uS+wsfhng+aQLdjtFZHSwAMeOBex+NkAL+BTqtLwL+XRI6HswMU6xK6XeVlT9/iQ20oglsxbMpV33R+YsJ4BX6mDWKrRPAaxVds17jU4FklemLvTLTIa1CbZ/bbuoH3Vvh5VH8Hc3BvV+3Hts9usPPbCX2kuS8pNflV7ecXVRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933474; c=relaxed/simple;
	bh=F35aLwqiILPCijHBnQlpwwzgTlzsYND2zjk9OXBKLGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSjurnE0z3cRQMSfDMNVt67ulm8XngkXosZB3fdn9eAN3JncmW7YG8lNO0OWJa+ydfHB2IxqKtI0DZCrgMRd0Na14BTsLb2Swme6F2CJqUccpzqRJmfyDNNFjGqQ5oquGJihflA8Xflsky9DdQDlN01ExYE74GQ6gCQCxofnF+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=MlaUS+f9; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f136e23229so3354131fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 01:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1722933470; x=1723538270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pKX6magl4mayyJYiocL/Ow+u/r2O2haRF9Xk/LPbes=;
        b=MlaUS+f9bbk8mvKD7tOP8enq/W0soQ611TtH6buy18W28mTdzaNLtMiIKmqjY5nafa
         0FPnQIx7ERKgCycGSj/fdslWN3cYpMEthyo5YY2dhi4SHLlummwWnQ/C+R232raNT/fi
         JBedRRBSUSFRLQYNc9Q2WV4CE+JpzkqeKGMzHoP3sQSoKmG9rIqB/XpreArs1HtTimkR
         MT4qEORa6gjERnGzhdrvfvASEkQ2YNCE8a7sJyL6atRm7VfypXl7R7amH07HLR4ANq2y
         R2f7pjbT+/z8TBjUmeftt/3OFW+ZuYM2JUpAqgImG1ScLIwuaiM46GF200waJJa0GgLK
         5nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722933470; x=1723538270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pKX6magl4mayyJYiocL/Ow+u/r2O2haRF9Xk/LPbes=;
        b=j3gp/0zJxoVZg4Pf8fPM46RjLDfhikaJNqCZaH/NNSdF1uGWI+q86oDkWmPDOWwKAE
         XPlLn4l71vnnTqPvu3VcDHSaJHNXSre0rFARroFJz8TU4Jv3Ty1/XZug4s/f/uJcYTro
         09VttoUMfidVbNWI6LCKqP9T50mwiSrDHfWYNAURV5YZvyQAcDrW8pfZZ0C7I2kdWuE7
         Y1vO1xyH/oQINafQUcIB05KbyzBAQre2BXQnKxEW+cvotns8nucnsXngfGI7/iFPlUZD
         MXrTAU9/5o3CMg62sPlyK6f3iGu71Twhx4kMuE5Zml5xgb08HLBzoP/JM7uSj/TkXUun
         rOAg==
X-Forwarded-Encrypted: i=1; AJvYcCUuv7CYiZ8DuzUdxtqad2vV2qz2QKbJC07Mc+mlIHfSGKbSyB1t0K7YmgQAwl1CCAAHUDFBtRT44bC9XSA17FehviAr4aC7TV2GENrj0g==
X-Gm-Message-State: AOJu0Yw4laEouWflkf/xH+bSDhJv70pZmz5JdFnAIaxmfUPU7fIAdqu6
	D8A9yiawDkyOwsf+vhLRieTtXxsrWhYbAPKccpj4ByKszzxk7CTaX6X9TLQytJY=
X-Google-Smtp-Source: AGHT+IF/1mmA3iQS7vSGDZrRgKwmmCxYZP+7ApvEaerc52qW0Oq+A98CGRDSByuWPnuMwetiNCuIDg==
X-Received: by 2002:a2e:8794:0:b0:2ef:1784:a20 with SMTP id 38308e7fff4ca-2f15ab0c2b7mr103652901fa.38.1722933469704;
        Tue, 06 Aug 2024 01:37:49 -0700 (PDT)
Received: from [10.8.7.139] ([84.252.147.250])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1b6443sm13791341fa.52.2024.08.06.01.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 01:37:44 -0700 (PDT)
Message-ID: <a69e15dc-62d4-4ab1-99d5-bfb982ab7f84@dubeyko.com>
Date: Tue, 6 Aug 2024 11:37:41 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bcachefs mount issue
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Jonathan Carter <jcc@debian.org>
Cc: linux-bcache@vger.kernel.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>, slava@dubeiko.com
References: <0D2287C8-F086-43B1-85FA-B672BFF908F5@dubeyko.com>
 <6l34ceq4gzigfv7dzrs7t4eo3tops7e5ryasdzv4fo5steponz@d5uqypjctrem>
Content-Language: en-US
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <6l34ceq4gzigfv7dzrs7t4eo3tops7e5ryasdzv4fo5steponz@d5uqypjctrem>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/6/24 03:50, Kent Overstreet wrote:
> On Mon, Aug 05, 2024 at 09:35:09PM GMT, Viacheslav Dubeyko wrote:
>> Hi Kent,
>>
>> As far as I  can see, I have found a mount issue. I believe that it’s a mkfs tool issue.
>>
>> ENVIRONMENT:
>> Linux ssdfs-test-0070 6.10.0 #15 SMP PREEMPT_DYNAMIC Mon Aug  5 19:00:55 MSK 2024 x86_64 x86_64 x86_64 GNU/Linux
>>
>> I am not sure how to share the mkfs.bcachefs tool version because this tool doesn’t show the version.
> 
> You're using an ancient version - I presume from Debian?
> 
> Debian hasn't been getting tools updates, you can't get anything modern
> because of, I believe, a libsodium transition (?), and modern 1.9.x
> versions aren't getting pushed out either.
> 
> I'll have to refer you to them - Jonathan, what's going on?
> 

I am using Ubuntu:

lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 22.04.3 LTS
Release:	22.04
Codename:	jammy

Thanks,
Slava.

>> REPRODUCTION PATH:
>>
>> (1) Format partition by mkfs tool of any file system (for example, NILFS2)
>> (2) Mount the prepared volume
>> (3) Execute any file system operations on the volume
>> (4) Unmount the volume
>> (5) Format partition by mkfs.bcachefs tool
>> (6) Try to mount the prepared  bcachefs volume
>> (7) The bcachefs logic fails too mount the formatted volume
>>
>> sudo mkfs.nilfs2 -f -b 4096 /dev/sda1
>> mkfs.nilfs2 (nilfs-utils 2.2.8)
>> Start writing file system initial data to the device
>>         Blocksize:4096  Device:/dev/sda1  Device Size:999292928
>> File system initialization succeeded !!
>>
>> sudo mount /dev/sda1 /mnt/test/
>>
>> mount
>> <skipped>
>> /dev/sda1 on /mnt/test type nilfs2 (rw,relatime)
>>
>> Aug  5 19:14:40 ssdfs-test-0070 kernel: [  520.066975] NILFS (sda1): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
>> Aug  5 19:14:40 ssdfs-test-0070 nilfs_cleanerd[3854]: start
>> Aug  5 19:14:40 ssdfs-test-0070 nilfs_cleanerd[3854]: pause (clean check)
>>
>> sudo umount /mnt/test
>>
>> Aug  5 19:15:18 ssdfs-test-0070 nilfs_cleanerd[3854]: shutdown
>>
>> sudo mkfs.bcachefs -f --block_size=4096 /dev/sda1
>> External UUID: 483fb669-63aa-4f41-b0ba-61eb2446c2fe
>> Internal UUID: 43527890-f6c8-43f1-bdd9-1c4936f71a8d
>> Device index: 0
>> Label:
>> Version: 14
>> Oldest version on disk: 14
>> Created: Mon Aug  5 19:20:32 2024
>> Squence number: 0
>> Block_size: 4.0K
>> Btree node size: 128.0K
>> Error action: ro
>> Clean: 0
>> Features: new_siphash,new_extent_overwrite,btree_ptr_v2,extents_above_btree_updates,btree_updates_journalled,new_varint,journal_no_flush,alloc_v2,extents_across_btree_nodes
>> Compat features:
>> Metadata replicas: 1
>> Data replicas: 1
>> Metadata checksum type: crc32c (1)
>> Data checksum type: crc32c (1)
>> Compression type: none (0)
>> Foreground write target: none
>> Background write target: none
>> Promote target: none
>> Metadata target:                none
>> String hash type: siphash (2)
>> 32 bit inodes: 1
>> GC reserve percentage: 8%
>> Root reserve percentage: 0%
>> Devices: 1 live, 1 total
>> Sections: members
>> Superblock size: 816
>>
>> Members (size 64):
>>    Device 0:
>>      UUID: 2c54ddfc-f50c-4d15-aa80-7d23474de3e6
>>      Size: 953.0M
>>      Bucket size: 128.0K
>>      First bucket: 0
>>      Buckets: 7624
>>      Last mount: (never)
>>      State: rw
>>      Group: (none)
>>      Data allowed: journal,btree,user
>>      Has data: (none)
>>      Replacement policy: lru
>>      Discard: 0
>> initializing new filesystem
>> going read-write
>> mounted with opts: (null)
>>
>> sudo mount /dev/sda1 /mnt/test/
>>
>> mount
>> <skipped>
>> /dev/sda1 on /mnt/test type nilfs2 (rw,relatime) <— completely unexpected
>>
>> Aug  5 19:21:13 ssdfs-test-0070 kernel: [  912.678991] NILFS (sda1): broken superblock, retrying with spare superblock (blocksize = 1024)
>> Aug  5 19:21:13 ssdfs-test-0070 kernel: [  912.679835] NILFS (sda1): broken superblock, retrying with spare superblock (blocksize = 4096)
>> Aug  5 19:21:13 ssdfs-test-0070 kernel: [  912.706795] NILFS (sda1): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
>> Aug  5 19:21:13 ssdfs-test-0070 nilfs_cleanerd[4751]: start
>> Aug  5 19:21:13 ssdfs-test-0070 nilfs_cleanerd[4751]: pause (clean check)
>>
>> sudo umount /mnt/test
>>
>> sudo mount -t bcachefs /dev/sda1 /mnt/test/
>> mount: /mnt/test: wrong fs type, bad option, bad superblock on /dev/sda1, missing codepage or helper program, or other error.
>>
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.311715] bcachefs (sda1): mounting version 0.14: btree_ptr_sectors_written opts=noshard_inode_numbers,journal_reclaim_delay=1000,nojournal_transaction_names
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.311753] bcachefs (sda1): recovering from clean shutdown, journal seq 4
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.311782] bcachefs (sda1): Version upgrade required:
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.311782] Doing incompatible version upgrade from 0.14: btree_ptr_sectors_written to 1.7: mi_btree_bitmap
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.311782]   running recovery passes: check_allocations,check_alloc_info,check_lrus,check_btree_backpointers,check_backpointers_to_extents,check_extents_to_backpointers,check_alloc_to_lru_refs,bucket_gens_init,check_snapshot_trees,check_snapshots,check_subvols,check_subvol_children,delete_dead_snapshots,check_inodes,check_extents,check_indirect_extents,check_dirents,check_xattrs,check_root,check_subvolume_structure,check_directory_structure,check_nlinks,delete_dead_inodes,set_fs_needs_rebalance
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.431462] bcachefs (sda1): alloc_read... done
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.431675] bcachefs (sda1): stripes_read... done
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.431688] bcachefs (sda1): snapshots_read... done
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.431702] bcachefs (sda1): check_allocations...
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.469609] dev 0 has wrong free buckets: got 0, should be 7537, fixing
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.469683]  done
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.471013] bcachefs (sda1): going read-write
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.471766] bcachefs (sda1): journal_replay... done
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.471794] bcachefs (sda1): check_alloc_info... done
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.472921] bcachefs (sda1): check_lrus... done
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.473309] bcachefs (sda1): check_btree_backpointers... done
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.473960] bcachefs (sda1): check_backpointers_to_extents... done
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474483] bcachefs (sda1): check_extents_to_backpointers...
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474582] missing backpointer for btree=inodes l=1 u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq d7dbe59ccc0e54fa written 24 min_key POS_MIN durability: 1 ptr: 0:78:0 gen 1
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474590]   got:   u64s 5 type deleted 0:20447232:0 len 0 ver 0
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474595]   want:  u64s 9 type backpointer 0:20447232:0 len 0 ver 0: bucket=0:78:0 btree=inodes l=1 offset=0:0 len=256 pos=SPOS_MAX, shutting down
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474645] bcachefs (sda1): inconsistency detected - emergency read only at journal seq 4
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474664] bcachefs (sda1): bch2_check_extents_to_backpointers(): error fsck_errors_not_fixed
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474682] bcachefs (sda1): bch2_fs_recovery(): error fsck_errors_not_fixed
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474692] bcachefs (sda1): bch2_fs_start(): error starting filesystem fsck_errors_not_fixed
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474842] bcachefs (sda1): unshutdown complete, journal seq 4
>> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.595522] bcachefs: bch2_mount() error: fsck_errors_not_fixed
>>
>> Thanks,
>> Slava.
>>
>>
>>
>>
>>

