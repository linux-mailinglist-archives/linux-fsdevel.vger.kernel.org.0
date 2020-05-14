Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14E01D32CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 16:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgENO1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 10:27:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:58372 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbgENO1j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 10:27:39 -0400
IronPort-SDR: fGbLIVfGazk4DGQXY6UjnGqkTI5ht3f/JLUjcgn8wQ++HfSqCIT//5iEo6wd+heWrvMT0izTUH
 OpyrnBvRwI3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 07:27:38 -0700
IronPort-SDR: GsJfjc4+wbQgYEdA7VycLrHz0AEfQpXpVVnHsViQIGodnrgeqcvY6S4ejn08z0TAcDQNXtedAf
 TM7x1TIgeUAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="437926254"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga005.jf.intel.com with ESMTP; 14 May 2020 07:27:37 -0700
Date:   Thu, 14 May 2020 07:27:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 7/9] fs/ext4: Make DAX mount option a tri-state
Message-ID: <20200514142737.GD2140786@iweiny-DESK2.sc.intel.com>
References: <20200514065316.2500078-1-ira.weiny@intel.com>
 <20200514065316.2500078-8-ira.weiny@intel.com>
 <20200514112553.GH9569@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514112553.GH9569@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 14, 2020 at 01:25:53PM +0200, Jan Kara wrote:
> On Wed 13-05-20 23:53:13, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > We add 'always', 'never', and 'inode' (default).  '-o dax' continue to
> > operate the same.
> > 
> > Specifically we introduce a 2nd DAX mount flag EXT4_MOUNT2_DAX_NEVER and set
> > it and EXT4_MOUNT_DAX_ALWAYS appropriately.
> > 
> > We also force EXT4_MOUNT2_DAX_NEVER if !CONFIG_FS_DAX.
> > 
> > https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from RFC:
> > 	Combine remount check for DAX_NEVER with DAX_ALWAYS
> > 	Update ext4_should_enable_dax()
> 
> ...
> 
> > @@ -2076,13 +2079,32 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
> >  		}
> >  		sbi->s_jquota_fmt = m->mount_opt;
> >  #endif
> > -	} else if (token == Opt_dax) {
> > +	} else if (token == Opt_dax || token == Opt_dax_str) {
> >  #ifdef CONFIG_FS_DAX
> > -		ext4_msg(sb, KERN_WARNING,
> > -		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> > -		sbi->s_mount_opt |= m->mount_opt;
> > +		char *tmp = match_strdup(&args[0]);
> > +
> > +		if (!tmp || !strcmp(tmp, "always")) {
> > +			ext4_msg(sb, KERN_WARNING,
> > +				"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> > +			sbi->s_mount_opt |= EXT4_MOUNT_DAX_ALWAYS;
> > +			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
> > +		} else if (!strcmp(tmp, "never")) {
> > +			sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_NEVER;
> > +			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
> > +		} else if (!strcmp(tmp, "inode")) {
> > +			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
> > +			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
> > +		} else {
> > +			ext4_msg(sb, KERN_WARNING, "DAX invalid option.");
> > +			kfree(tmp);
> > +			return -1;
> > +		}
> > +
> > +		kfree(tmp);
> 
> As I wrote in my reply to previous version of this patch, I'd prefer if we
> handled this like e.g. 'data=' mount option. I don't think any unification
> in option parsing with XFS makes sence and I'd rather keep consistent how
> ext4 handles these 'enum' options.

Ok...  I'm sorry I'll change this.  Thanks for all the reviews!
Ira

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
