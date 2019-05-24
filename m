Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C817C28F6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 05:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbfEXDKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 23:10:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59272 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387559AbfEXDKF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 23:10:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 57A496087A; Fri, 24 May 2019 03:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558667404;
        bh=O7cQI3hKqwLum3dHopYKUX9rFdvXxU3XnAEloPidYkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KwcgVa2aLbELxlhUSZKkPZEkpNP+qGfug1/VE4DtHmC5AIZQAiqt+W1R3LkCvb/sN
         PEmBPBONx4nN3iS2WKb7lSVrRwcpr6GcVPH502i3r3hBToAuz/yxH37xdcqs82ZVjq
         aC72j52i4R9fd7DSpGsLnjCGa09hneTV44ishI8g=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D418660878;
        Fri, 24 May 2019 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558667403;
        bh=O7cQI3hKqwLum3dHopYKUX9rFdvXxU3XnAEloPidYkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WuQbAxZ9GbJEdO1ImtXt4dxUx6Brtsq+dRj53DdHfIAxhNCxoNf45ng0buMrWweno
         txVw4F0fyn0jiRnVKgrWmB2p2KK3W8b64PvP87ms7v1JsBYnwBBZBPeolxtR7BCVl4
         sOctgbc2rTrMZ+16uESeWBzZcyT2EL6t8Va1Z8JM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D418660878
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Fri, 24 May 2019 08:39:58 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     sunqiuyang <sunqiuyang@huawei.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v6 1/1] f2fs: ioctl for removing a range from F2FS
Message-ID: <20190524030958.GB10043@codeaurora.org>
References: <20190524015555.12622-1-sunqiuyang@huawei.com>
 <e7cfed52-0212-834f-aed8-0c5abc07f779@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7cfed52-0212-834f-aed8-0c5abc07f779@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 24, 2019 at 10:32:07AM +0800, Chao Yu wrote:
> +Cc Sahitya,
> 
> On 2019/5/24 9:55, sunqiuyang wrote:
> > From: Qiuyang Sun <sunqiuyang@huawei.com>
> > 
> > This ioctl shrinks a given length (aligned to sections) from end of the
> > main area. Any cursegs and valid blocks will be moved out before
> > invalidating the range.
> > 
> > This feature can be used for adjusting partition sizes online.
> > --
> > Changlog v1 ==> v2:
> > 
> > Sahitya Tummala:
> >  - Add this ioctl for f2fs_compat_ioctl() as well.
> >  - Fix debugfs status to reflect the online resize changes.
> >  - Fix potential race between online resize path and allocate new data
> >    block path or gc path.
> > 
> > Others:
> >  - Rename some identifiers.
> >  - Add some error handling branches.
> >  - Clear sbi->next_victim_seg[BG_GC/FG_GC] in shrinking range.
> > --
> > Changelog v2 ==> v3:
> > Implement this interface as ext4's, and change the parameter from shrunk
> > bytes to new block count of F2FS.
> > --
> > Changelog v3 ==> v4:
> >  - During resizing, force to empty sit_journal and forbid adding new
> >    entries to it, in order to avoid invalid segno in journal after resize.
> >  - Reduce sbi->user_block_count before resize starts.
> >  - Commit the updated superblock first, and then update in-memory metadata
> >    only when the former succeeds.
> >  - Target block count must align to sections.
> > --
> > Changelog v4 ==> v5:
> > Write checkpoint before and after committing the new superblock, w/o
> > CP_FSCK_FLAG respectively, so that the FS can be fixed by fsck even if
> > resize fails after the new superblock is committed.
> > --
> > Changelog v5 ==> v6:
> >  - In free_segment_range(), reduce granularity of gc_mutex.
> >  - Add protection on curseg migration.
> > 
> > Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> 
> Looks good to me now,
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> To Sahitya, is it okay to you merging all your fixes and adding Signed-off in
> original patch? We can still separate them from this patch if you object this,
> let us know.
> 

Hi Chao,

I am okay with merging.

Thanks,
Sahitya.

> Thanks,

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
