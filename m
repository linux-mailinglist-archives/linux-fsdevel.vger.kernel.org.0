Return-Path: <linux-fsdevel+bounces-27056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFE795E0B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 04:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89DCB1F21AF0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 02:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F778489;
	Sun, 25 Aug 2024 02:01:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FBA1FA5
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Aug 2024 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724551302; cv=none; b=ln+ZJhWO5qL6Fh2feikqDA4awY/rR+/vQEnNmCPXxvYC7Et/bpwuTf7AD2pzcl3bLr39gPP/0zr32zHMy4WYVp1fTjNt3GG6HUJHFWdH+Zl5p/JJqK1Vc+EBX9h+uzLzP4gKLtnd8eHjJLvaDkQh59NClW52/4VLh6BkmlZX7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724551302; c=relaxed/simple;
	bh=4xAUDQ5Xa1nBWD0nbczHkPr0m3ym6tcLEMSWnybSeoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ePJyp5q6GDKr7S26QcmvxqQSelUhfwjo/PlrTKC+YN/bX+SdW7DVpbv4th1V6XBr3CI4OWxnDENFiS76V82kGJ8YqhFsXa003jvKOeJHFBOB1HfyRpxKshK0Mip2DkQVqzoRTd/TNRL5a9d5UyZi6Waf1eYHBcfKD0Y49VAgdGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one; spf=pass smtp.mailfrom=nom.one; arc=none smtp.client-ip=64.142.111.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nom.one
Received: from 192-184-190-65.static.sonic.net (192-184-190-65.static.sonic.net [192.184.190.65])
	(authenticated bits=0)
	by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPA id 47P1oeJg025924;
	Sat, 24 Aug 2024 18:50:41 -0700
From: Forest <forestix@nom.one>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc: linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, regressions@lists.linux.dev
Subject: [REGRESSION] cifs: triggers bad flatpak & ostree signatures, corrupts ffmpeg & mkvmerge outputs
Date: Sat, 24 Aug 2024 18:50:40 -0700
Message-ID: <pv2lcjhveti4sfua95o0u6r4i73r39srra@sonic.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Sonic-CAuth: UmFuZG9tSVbLHoUERX1vtYlwpdseB4XYWtL2dShvfjUov/JNCh945aBnRL4VeQXkDwI4V2nIoHpMTu1rLsWf2EGRvohwCNK8
X-Sonic-ID: C;pEX8boRi7xGqg65Sr7edkQ== M;NEsRb4Ri7xGqg65Sr7edkQ==
X-Spam-Flag: No
X-Sonic-Spam-Details: -0.0/5.0 by cerberusd

#regzbot introduced: 3ee1a1fc3981

Dear maintainers,

I think I have found a cifs regression in the 6.10 kernel series, which leads
certain programs to write corrupt data.

After upgrading from kernel 6.9.12 to 6.10.6, flatpak and ostree are now
writing bad gpg signatures when exporting signed packages or signing their
repository metadata/summary files, whenever the repository is on a cifs mount.
Instead of writing the signature data, null bytes are written in its place.

Furthermore, ffmpeg and mkvmerge are now intermittently writing corrupt files
to cifs mounts.

No error is reported by the applications or the kernel when it happens.
In the case of flatpak, the problem isn't revealed until something tries to use
the repository and finds signatures full of null bytes. (Of course, this means
the affected repositories have been rendered useless.) In the case of ffmpeg
and mkvmerge, the problem isn't revealed until someone plays the video file and
reaches a corrupt section.


A kernel bisect reveals this:

3ee1a1fc39819906f04d6c62c180e760cd3a689d is the first bad commit
commit 3ee1a1fc39819906f04d6c62c180e760cd3a689d
Author: David Howells <dhowells@redhat.com>
Date:   Fri Oct 6 18:29:59 2023 +0100
    cifs: Cut over to using netfslib

I was unable to determine whether 6.11.0-rc4 fixes it, due to another cifs bug
in that version (which I hope to report soon).


An strace of flatpak (which uses libostree) shows it generating correct
signatures internally, but behaving differently on cifs vs. ext4 when working
with memory-mapped temp files, in which the signatures are stored before being
written to their final outputs. Here's where I reported my initial findings to
those projects:
https://github.com/flatpak/flatpak/issues/5911
https://github.com/ostreedev/ostree/issues/3288

Debian Testing and Unstable kernels (6.10.4-1 and 6.10.6-1) are affected:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1079394


The following reproducer script consistently triggers the problem for me. Run
it with two arguments: a path on a cifs mount where an ostree repo should be
created, and a GPG key ID with which to sign a commit.


#!/bin/sh
set -e

if [ "$#" -lt 2 ] || [ "$1" = "-h" ] ; then
    echo "usage: $(basename "$0") <repo-dir> <gpg-key-id>"
    exit 2
fi

repo=$1
keyid=$2
src="./foo"

echo "creating ostree repo at $repo"
ostree init --repo="$repo"

echo "creating source file tree at $src"
mkdir -p "$src"
echo hi > "$src"/hello

ostree commit --repo="$repo" --branch=foo --gpg-sign="$keyid" "$src"

if ostree show --repo="$repo" foo; then
    echo ---
    echo success!
else
    echo ---
    ostree show --repo="$repo" --print-detached-metadata-key=ostree.gpgsigs foo
    echo failure!
    echo look for null bytes in the above commit signature
fi



