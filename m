Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF30363F4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 12:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhDSKIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 06:08:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:36826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhDSKIO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 06:08:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 282B4AF2F;
        Mon, 19 Apr 2021 10:07:44 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 38c80723;
        Mon, 19 Apr 2021 10:09:12 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v6 20/20] ceph: add fscrypt ioctls
References: <20210413175052.163865-1-jlayton@kernel.org>
        <20210413175052.163865-21-jlayton@kernel.org>
Date:   Mon, 19 Apr 2021 11:09:12 +0100
In-Reply-To: <20210413175052.163865-21-jlayton@kernel.org> (Jeff Layton's
        message of "Tue, 13 Apr 2021 13:50:52 -0400")
Message-ID: <87lf9emvqv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff!

Jeff Layton <jlayton@kernel.org> writes:
<...>
> +
> +	case FS_IOC_ADD_ENCRYPTION_KEY:
> +		ret = vet_mds_for_fscrypt(file);
> +		if (ret)
> +			return ret;
> +		atomic_inc(&ci->i_shared_gen);

After spending some (well... a lot, actually) time looking at the MDS code
to try to figure out my bug, I'm back at this point in the kernel client
code.  I understand that this code is trying to invalidate the directory
dentries here.  However, I just found that the directory we get at this
point is the filesystem root directory, and not the directory we're trying
to unlock.

So, I still don't fully understand the issue I'm seeing, but I believe the
code above is assuming 'ci' is the inode being unlocked, which isn't
correct.

(Note: I haven't checked if there are other ioctls getting the FS root.)

Cheers,
-- 
Luis
