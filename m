Return-Path: <linux-fsdevel+bounces-18381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DDB8B7F6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 20:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A346D1F2348C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 18:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DAE181328;
	Tue, 30 Apr 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FurPK9Ph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B840175560
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500397; cv=none; b=n/TkP7tB5KQSj0UnPFiWX+kviDjcqUKUc2uBc3vl1mfaJJqipUI2rfIlzgXDOJsCPnAntZIh765dY/ps4ZYINX78dL0FDqeZUxmKset3HXQ6G9ZOlNIqJQmWWsoLgdLyazsR/epfvzljmiorTwe45+cSqrU1f4mw3HVI3hAhpiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500397; c=relaxed/simple;
	bh=PwI1PrOotdPpKXX5QAwi15HY6YoGol2geJBgw3UZ8VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arMjVU+VMFt4ZsIhRiK/WOeVZKz1a9HQVhJSqNh0ReokROfyyxb5gLZHmx08eO/VzujfvsXDxL0XFVx2dkfmfLwO1hL1v3YVVDEnARZq3tbzptv3FlLeiByjCzVuqEaKglvZ8xtlA4g6zMkJf17eL7+/bjfz3F1R56za++Na4OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FurPK9Ph; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714500394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=imQQal1msniqCC7SSyjMUlHWjAzNmLrGF8VoQ2n0MHk=;
	b=FurPK9Phz3EOrdqIyPyd+RNYP4n2OzpTJkKAvs2C5+P688MN6rAieAV0VRYDflmS1Gyw4k
	SCRN+hQ8w1FeVn/fbHbXzGNyrj9U4NWP5jeqeXwjDGDLTAmcC3ShZO4+bnVistbuglMXo/
	RCeOv3x2eC058vUabredyrrnd2MjsRU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-fluHSI94OvyEcKOAXYARfw-1; Tue, 30 Apr 2024 14:06:32 -0400
X-MC-Unique: fluHSI94OvyEcKOAXYARfw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a558739aaf4so361169566b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 11:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714500391; x=1715105191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imQQal1msniqCC7SSyjMUlHWjAzNmLrGF8VoQ2n0MHk=;
        b=Hr9zyg/hQuC4QzZ+R4NuPa52F0MiFENOkPwyv/rki9Cm9lir5lh4fSL2UF8orFZpyk
         win6P/WQXXPNhGLiPDX9CF9wjaEQXwi+gTwc0vCeVS8eUefP8rOkVL1xRfPiAC2C8lkg
         z5ZQ8yG2l/0vHXZ1c4R/aUSArqqXCaS3umQ817zGje21ATVcHCQNrlVQ0oYoKSi3m2vm
         GqF8x/GbdEBYh/8+Ypn1dx6poqwadwMMg2INQPnYUwCcxKEYfrNA+whUFL82mx+fpJ+f
         G5RLOd8XDTdrVsAioPadRrxvqtHDbKJz1XDSzEGnjjGUlTWFanNzgu4zzyjwV5Ji/9su
         fMJg==
X-Forwarded-Encrypted: i=1; AJvYcCWNiYXwzmKQTuWAmU/V59XFldlWHLDW2ZvDgpwVEmFmUOfaN4aZt/WH8d+n8D5pt238GG74VYNjtjzRLRoSHZKXf7n6g+/KqCqDCxIMjw==
X-Gm-Message-State: AOJu0YwDkgbsFSUhKhX4Y8/NvGWo4RZQHlvlqFgHkBPHQVyZyajNMeWf
	UhuON28CzpUryEmy3z7iauDMqkOYtfsKyJuSTifhclAH8LI80YrhSXtBIhzDEbEyKTXQdrrzJxY
	SmLQ9TAT3vr0ZpsMWoJCIk2oPwwalqxC59AlrYRY6BrE5w45Op6YCB0G1P6ZSuA==
X-Received: by 2002:a17:906:3952:b0:a52:2c4f:7957 with SMTP id g18-20020a170906395200b00a522c4f7957mr336760eje.66.1714500390992;
        Tue, 30 Apr 2024 11:06:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjmyO5251sKWtcwGbGfFOrVzhA6dBFSD9UqK7uJf0jtnRf/sKg9Lc8u0v7WdZoeggiao3A+Q==
X-Received: by 2002:a17:906:3952:b0:a52:2c4f:7957 with SMTP id g18-20020a170906395200b00a522c4f7957mr336746eje.66.1714500390308;
        Tue, 30 Apr 2024 11:06:30 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id v5-20020a170906380500b00a58f36e5fecsm3720608ejc.67.2024.04.30.11.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 11:06:29 -0700 (PDT)
Date: Tue, 30 Apr 2024 20:06:29 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, guan@eryu.me, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 5/6] xfs: test disabling fsverity
Message-ID: <uffkpx5hbin4ym3jmechs4yuby3x2azze56mo4afyy6op3ysro@y6kpnc2ixyue>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688055.962488.12884471948592949028.stgit@frogsfrogsfrogs>
 <cjwdgeptjooy65czttyopop4ipkxmdxgdkxxdpfsmtdtzr5jbj@6bu7ql72wtue>
 <20240430154810.GM360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430154810.GM360919@frogsfrogsfrogs>

On 2024-04-30 08:48:10, Darrick J. Wong wrote:
> On Tue, Apr 30, 2024 at 03:11:11PM +0200, Andrey Albershteyn wrote:
> > On 2024-04-29 20:42:05, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Add a test to make sure that we can disable fsverity on a file that
> > > doesn't pass fsverity validation on its contents anymore.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  tests/xfs/1881     |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/xfs/1881.out |   28 +++++++++++++
> > >  2 files changed, 139 insertions(+)
> > >  create mode 100755 tests/xfs/1881
> > >  create mode 100644 tests/xfs/1881.out
> > > 
> > > 
> > > diff --git a/tests/xfs/1881 b/tests/xfs/1881
> > > new file mode 100755
> > > index 0000000000..411802d7c7
> > > --- /dev/null
> > > +++ b/tests/xfs/1881
> > > @@ -0,0 +1,111 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 1881
> > > +#
> > > +# Corrupt fsverity descriptor, merkle tree blocks, and file contents.  Ensure
> > > +# that we can still disable fsverity, at least for the latter cases.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick verity
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	_restore_fsverity_signatures
> > > +	rm -f $tmp.*
> > > +}
> > > +
> > > +. ./common/verity
> > > +. ./common/filter
> > > +. ./common/fuzzy
> > > +
> > > +_supported_fs xfs
> > > +_require_scratch_verity
> > > +_disable_fsverity_signatures
> > > +_require_fsverity_corruption
> > > +_require_xfs_io_command noverity
> > > +_require_scratch_nocheck	# corruption test
> > > +
> > > +_scratch_mkfs >> $seqres.full
> > > +_scratch_mount
> > > +
> > > +_require_xfs_has_feature "$SCRATCH_MNT" verity
> > > +VICTIM_FILE="$SCRATCH_MNT/a"
> > > +_fsv_can_enable "$VICTIM_FILE" || _notrun "cannot enable fsverity"
> > > +
> > > +create_victim()
> > > +{
> > > +	local filesize="${1:-3}"
> > > +
> > > +	rm -f "$VICTIM_FILE"
> > > +	perl -e "print 'moo' x $((filesize / 3))" > "$VICTIM_FILE"
> > > +	fsverity enable --hash-alg=sha256 --block-size=1024 "$VICTIM_FILE"
> > > +	fsverity measure "$VICTIM_FILE" | _filter_scratch
> > > +}
> > > +
> > > +disable_verity() {
> > > +	$XFS_IO_PROG -r -c 'noverity' "$VICTIM_FILE" 2>&1 | _filter_scratch
> > > +}
> > > +
> > > +cat_victim() {
> > > +	$XFS_IO_PROG -r -c 'pread -q 0 4096' "$VICTIM_FILE" 2>&1 | _filter_scratch
> > > +}
> > > +
> > > +echo "Part 1: Delete the fsverity descriptor" | tee -a $seqres.full
> > > +create_victim
> > > +_scratch_unmount
> > > +_scratch_xfs_db -x -c "path /a" -c "attr_remove -f vdesc" -c 'ablock 0' -c print >> $seqres.full
> > > +_scratch_mount
> > > +cat_victim
> > > +
> > > +echo "Part 2: Disable fsverity, which won't work" | tee -a $seqres.full
> > > +disable_verity
> > > +cat_victim
> > > +
> > > +echo "Part 3: Corrupt the fsverity descriptor" | tee -a $seqres.full
> > > +create_victim
> > > +_scratch_unmount
> > > +_scratch_xfs_db -x -c "path /a" -c 'attr_modify -f "vdesc" -o 0 "BUGSAHOY"' -c 'ablock 0' -c print >> $seqres.full
> > > +_scratch_mount
> > > +cat_victim
> > > +
> > > +echo "Part 4: Disable fsverity, which won't work" | tee -a $seqres.full
> > > +disable_verity
> > > +cat_victim
> > > +
> > > +echo "Part 5: Corrupt the fsverity file data" | tee -a $seqres.full
> > > +create_victim
> > > +_scratch_unmount
> > > +_scratch_xfs_db -x -c "path /a" -c 'dblock 0' -c 'blocktrash -3 -o 0 -x 24 -y 24 -z' -c print >> $seqres.full
> > > +_scratch_mount
> > > +cat_victim
> > > +
> > > +echo "Part 6: Disable fsverity, which should work" | tee -a $seqres.full
> > > +disable_verity
> > > +cat_victim
> > > +
> > > +echo "Part 7: Corrupt a merkle tree block" | tee -a $seqres.full
> > > +create_victim 1234 # two merkle tree blocks
> > > +_fsv_scratch_corrupt_merkle_tree "$VICTIM_FILE" 0
> > 
> > hmm, _fsv_scratch_corrupt_merkle_tree calls _scratch_xfs_repair, and
> > now with xfs_repair knowing about fs-verity is probably a problem. I
> 
> It shouldn't be -- xfs_repair doesn't check the contents of the merkle
> tree itself.
> 
> (xfs_scrub sort of does, but only by calling out to the kernel fsverity
> code to get rough tree geometry and calling MADV_POPULATE_READ to
> exercise the read validation.)

oh right, it's xfs_scrub, I meant re-reading file validation

> 
> > don't remember what was the problem with quota (why xfs_repiar is
> > there), I can check it.
> 
> If the attr_modify commandline changes the block count of the file, it
> won't update the quota accounting information.  That can happen if the
> dabtree changes shape, or if the new attr requires the creation of a new
> attr leaf block, or if the remote value block count changes due to
> changes in the size of the attr value.

aha, yeah

-- 
- Andrey


