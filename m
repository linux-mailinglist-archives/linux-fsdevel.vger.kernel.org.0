Return-Path: <linux-fsdevel+bounces-18373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCDE8B7BBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 17:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9FA1C2438F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CAA172BCB;
	Tue, 30 Apr 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwHFCjwQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23E1527AF;
	Tue, 30 Apr 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491316; cv=none; b=lJRzjA6LlzR7+/WYMQfscTv3obsnRdwuU7PMCJQmpR/i37P+9pmKofHT54xDFK8eDWp34KDazpO3XSrbWBC1dKq7eugDa+3zmLJR9S0LFNA2tsKzDuON0IiYYSbrvOdAWEZY53+AdVkfryE2n8ODT/V9piSihzxmQOOxCwKJ78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491316; c=relaxed/simple;
	bh=MbkN7pDkKZZWrXoY+9HjWqjVPDtjbX2R4sqx3TF+2/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGmrtmFbZTJcp46L6rfODrEGcHM8OzukdcDQRRit9JAgWZO0eEkiVfcTD6JoSs31RZ2tEkcibEexceUbwlqxsNBFQrAgrOFg+F/cYZBAUCHnHBTPrD0UImu+hvSJPw8V/PFGg0n984G1Jz3Ka0KOl/zSeyOBoIUBIWWkclbecVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwHFCjwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1100C4AF18;
	Tue, 30 Apr 2024 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714491315;
	bh=MbkN7pDkKZZWrXoY+9HjWqjVPDtjbX2R4sqx3TF+2/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwHFCjwQLj8OrvPqlUqBGFI7Elph1AP0qS1oXee51RVpufvEYrlgFOuWpzBS2HfnH
	 GkM1pQWVLCgFBqK40OnYkRaQr4PaDrCy0O48B7RSYbIXvRTPfTni2BbwBRlQaeb4Ja
	 iVydtk85OZS3SpY0bosB7hp9JLrgbGGxiwLtWU1lYWQpQUZls7TjJUwBJQ98GVqQp7
	 F9XgUXF9oR1RZcqkLqI2xv+I3pzzwGam75XDXEVNYUbB96R6m1KpfLxVO/2y0ZV3+v
	 mGKgFKEpvUJV3fvnY0L/cQGTcK0tsLR1qKZ1E1oRgS2JGFySX5xvphQ8wy3zafP7Iy
	 taw7XI1m0Ogow==
Date: Tue, 30 Apr 2024 08:35:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: zlang@redhat.com, ebiggers@kernel.org,
	Andrey Albershteyn <andrey.albershteyn@gmail.com>,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	guan@eryu.me, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/6] common/verity: enable fsverity for XFS
Message-ID: <20240430153515.GI360919@frogsfrogsfrogs>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444687994.962488.5112127418406573234.stgit@frogsfrogsfrogs>
 <owfufxxoyiv3f67shc42n7pxvw4ippzjgukn3lfhayu5uraeci@pmqvwjh2u424>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <owfufxxoyiv3f67shc42n7pxvw4ippzjgukn3lfhayu5uraeci@pmqvwjh2u424>

On Tue, Apr 30, 2024 at 02:39:04PM +0200, Andrey Albershteyn wrote:
> On 2024-04-29 20:41:03, Darrick J. Wong wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > XFS supports verity and can be enabled for -g verity group.
> > 
> > Signed-off-by: Andrey Albershteyn <andrey.albershteyn@gmail.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  common/verity |   39 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 37 insertions(+), 2 deletions(-)
> > 
> > 
> > diff --git a/common/verity b/common/verity
> > index 59b67e1201..20408c8c0e 100644
> > --- a/common/verity
> > +++ b/common/verity
> > @@ -43,7 +43,16 @@ _require_scratch_verity()
> >  
> >  	# The filesystem may be aware of fs-verity but have it disabled by
> >  	# CONFIG_FS_VERITY=n.  Detect support via sysfs.
> > -	if [ ! -e /sys/fs/$fstyp/features/verity ]; then
> > +	case $FSTYP in
> > +	xfs)
> > +		_scratch_unmount
> > +		_check_scratch_xfs_features VERITY &>>$seqres.full
> > +		_scratch_mount
> > +	;;
> > +	*)
> > +		test -e /sys/fs/$fstyp/features/verity
> > +	esac
> > +	if [ ! $? ]; then
> >  		_notrun "kernel $fstyp isn't configured with verity support"
> >  	fi
> >  
> > @@ -201,6 +210,9 @@ _scratch_mkfs_verity()
> >  	ext4|f2fs)
> >  		_scratch_mkfs -O verity
> >  		;;
> > +	xfs)
> > +		_scratch_mkfs -i verity
> > +		;;
> >  	btrfs)
> >  		_scratch_mkfs
> >  		;;
> > @@ -334,12 +346,19 @@ _fsv_scratch_corrupt_bytes()
> >  	local lstart lend pstart pend
> >  	local dd_cmds=()
> >  	local cmd
> > +	local device=$SCRATCH_DEV
> >  
> >  	sync	# Sync to avoid unwritten extents
> >  
> >  	cat > $tmp.bytes
> >  	local end=$(( offset + $(_get_filesize $tmp.bytes ) ))
> >  
> > +	# If this is an xfs realtime file, switch @device to the rt device
> > +	if [ $FSTYP = "xfs" ]; then
> > +		$XFS_IO_PROG -r -c 'stat -v' "$file" | grep -q -w realtime && \
> > +			device=$SCRATCH_RTDEV
> > +	fi
> > +
> >  	# For each extent that intersects the requested range in order, add a
> >  	# command that writes the next part of the data to that extent.
> >  	while read -r lstart lend pstart pend; do
> > @@ -355,7 +374,7 @@ _fsv_scratch_corrupt_bytes()
> >  		elif (( offset < lend )); then
> >  			local len=$((lend - offset))
> >  			local seek=$((pstart + (offset - lstart)))
> > -			dd_cmds+=("head -c $len | dd of=$SCRATCH_DEV oflag=seek_bytes seek=$seek status=none")
> > +			dd_cmds+=("head -c $len | dd of=$device oflag=seek_bytes seek=$seek status=none")
> >  			(( offset += len ))
> >  		fi
> >  	done < <($XFS_IO_PROG -r -c "fiemap $offset $((end - offset))" "$file" \
> > @@ -408,6 +427,22 @@ _fsv_scratch_corrupt_merkle_tree()
> >  		done
> >  		_scratch_mount
> >  		;;
> > +	xfs)
> > +		local ino=$(stat -c '%i' $file)
> 
> I didn't know about xfs_db's "path" command, this can be probably
> replace with -c "path $file", below in _scratch_xfs_db.

You /can/ use the xfs_db path command here, but then you have to strip
out $SCRATCH_MNT from $file since it of course doesn't know about mount
points.  Since $file is a file path, we might as well use stat to find
the inumber.

> > +		local attr_offset=$(( $offset % $FSV_BLOCK_SIZE ))
> > +		local attr_index=$(printf "%08d" $(( offset - attr_offset )))
> > +		_scratch_unmount
> > +		# Attribute name is 8 bytes long (byte position of Merkle tree block)
> > +		_scratch_xfs_db -x -c "inode $ino" \
>                                 here   ^^^^^^^^^^
> > +			-c "attr_modify -f -m 8 -o $attr_offset $attr_index \"BUG\"" \
> > +			-c "ablock 0" -c "print" \
> > +			>>$seqres.full
> > +		# In case bsize == 4096 and merkle block size == 1024, by
> > +		# modifying attribute with 'attr_modify we can corrupt quota
> > +		# account. Let's repair it
> > +		_scratch_xfs_repair >> $seqres.full 2>&1
> > +		_scratch_mount
> > +		;;
> >  	*)
> >  		_fail "_fsv_scratch_corrupt_merkle_tree() unimplemented on $FSTYP"
> >  		;;
> > 
> > 
> 
> Otherwise, looks good to me:
> Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

<nod>

--D

> -- 
> - Andrey
> 
> 

