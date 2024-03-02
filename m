Return-Path: <linux-fsdevel+bounces-13345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 640B886EE17
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 03:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FEBB21AF9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 02:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797AD7490;
	Sat,  2 Mar 2024 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dpk2Es87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29FE63AE
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709345699; cv=none; b=TEUC6m4pypx22fsIbknLe7XjQXnQGn5NdLmzOUOoPkyhRcZud0/wcqhuXxTbdmstKcMNVYHzg27fGXnS6AjA8F/O0beIUaPvLUSNyLnCj3P5Nx4UBeyeHMbEk8aP5aDY6OZkaNFiMwBgZK2sjmTVES/w6+0DLzR19uWLyxG7yIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709345699; c=relaxed/simple;
	bh=xdUH8yt56H1yrlX9btyLfY5jD2X0MPDmpzirbToSkN0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DU+qaO2jrXb5g8itbv1yVy5fkgxSCQ8SqW1Dx8x/dGNGQ93GDU4eBoYlVyG7R2VFFGWFPWYEwvPTwONnSkCxNXt5AUUbHwqlkLSxpzS4fIyz9qlcyrQYulf2a83hhunzmMSZPaym89rnU+IPCdLfegQeeQAAomQenQxYrgBbmgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dpk2Es87; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 1 Mar 2024 21:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709345695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=SLhMFb9RPBAVJDy0ylhiUFPZYEbcZieEIC/CfKQNaUQ=;
	b=Dpk2Es87o5cb0ruLrDNl0GHFI1Zz8TwMOVzXb8YkI7CBIisdANsCZ8u0BSWo2Q0+ppxECs
	Wm2o8+aLXxhWQ+tbLhUnYjuAAAJlTMUWxhoVby4PDR++QkiSS3351AlhLScgGojZtqz4Jw
	GiGM0j6VboSzMFx5mr4kE+9NIrtooLs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [WIP] bcachefs fs usage update
Message-ID: <gajhq3iyluwmr44ee2fzacfpgpxmr2jurwqg6aeiab4lfila3p@b3l7bywr3yed>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

I'm currently updating the 'bcachefs fs usage' command for the disk
accounting rewrite, and looking for suggestions on any improements we
could make - ways to present the output that would be clearer and more
useful, possibly ideas on on new things to count...

I think a shorter form of the per-device section is in order, a table
with data type on the x axis and the device on the y axis; we also want
percentages.

The big thing I'm trying to figure out is how to present the snapshots
counters in a useful way.

Snapshot IDs form trees, where subvolumes correspond to leaf nodes in
snapshot trees and interior nodes represent data shared between multiple
subvolumes.

That means it's straightforward to print how much data each subvolumme
is using directly - look up the subvolume for a given snapshot ID, look
up the filesystem path of that subvolume - but I haven't come up with a
good way of presenting how data is shared; these trees can be
arbitrarily large.

Thoughts?

Filesystem: 77d3a40d-58b6-46c9-a4d2-e59c8681e152
Size:                       11.0 GiB
Used:                       4.96 GiB
Online reserved:                 0 B
Inodes:                            4

Persistent reservations:
2x                          5.00 MiB

Data type       Required/total  Durability    Devices
btree:          1/2             2             [vdb vdc]           14.0 MiB
btree:          1/2             2             [vdb vdd]           17.8 MiB
btree:          1/2             2             [vdc vdd]           14.3 MiB
user:           1/2             2             [vdb vdc]           1.64 GiB
user:           1/2             2             [vdb vdd]           1.63 GiB
user:           1/2             2             [vdc vdd]           1.64 GiB

Compression:      compressed    uncompressed     average extent size
lz4                 4.63 GiB        6.57 GiB                 112 KiB
incompressible       328 MiB         328 MiB                 113 KiB

Snapshots:
4294967295          4.91 GiB

Btrees:
extents             12.0 MiB
inodes               256 KiB
dirents              256 KiB
alloc               10.8 MiB
subvolumes           256 KiB
snapshots            256 KiB
lru                  256 KiB
freespace            256 KiB
need_discard         256 KiB
backpointers        20.5 MiB
bucket_gens          256 KiB
snapshot_trees       256 KiB
logged_ops           256 KiB
accounting           256 KiB

(no label) (device 0):           vdb              rw
                                data         buckets    fragmented
  free:                     2.27 GiB           18627
  sb:                       3.00 MiB              25       124 KiB
  journal:                  32.0 MiB             256
  btree:                    15.9 MiB             127
  user:                     1.64 GiB           13733      41.1 MiB
  cached:                        0 B               0
  parity:                        0 B               0
  stripe:                        0 B               0
  need_gc_gens:                  0 B               0
  need_discard:                  0 B               0
  capacity:                 4.00 GiB           32768

(no label) (device 1):           vdc              rw
                                data         buckets    fragmented
  free:                     2.28 GiB           18652
  sb:                       3.00 MiB              25       124 KiB
  journal:                  32.0 MiB             256
  btree:                    14.1 MiB             113
  user:                     1.64 GiB           13722      38.5 MiB
  cached:                        0 B               0
  parity:                        0 B               0
  stripe:                        0 B               0
  need_gc_gens:                  0 B               0
  need_discard:                  0 B               0
  capacity:                 4.00 GiB           32768

(no label) (device 2):           vdd              rw
                                data         buckets    fragmented
  free:                     2.28 GiB           18640
  sb:                       3.00 MiB              25       124 KiB
  journal:                  32.0 MiB             256
  btree:                    16.0 MiB             128
  user:                     1.64 GiB           13719      38.6 MiB
  cached:                        0 B               0
  parity:                        0 B               0
  stripe:                        0 B               0
  need_gc_gens:                  0 B               0
  need_discard:                  0 B               0
  capacity:                 4.00 GiB           32768

