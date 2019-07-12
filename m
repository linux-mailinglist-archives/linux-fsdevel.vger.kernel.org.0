Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65605669FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfGLJfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 05:35:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:33582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbfGLJfq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:35:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 116FDAC1C;
        Fri, 12 Jul 2019 09:35:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C913E1E43CA; Fri, 12 Jul 2019 11:35:44 +0200 (CEST)
Date:   Fri, 12 Jul 2019 11:35:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     "Steven J. Magnani" <steve.magnani@digidescorp.com>,
        "Steven J . Magnani" <steve@digidescorp.com>,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] udf: refactor VRS descriptor identification
Message-ID: <20190712093544.GE906@quack2.suse.cz>
References: <20190711133852.16887-1-steve@digidescorp.com>
 <20190711181521.fqsbatc2oslo2v5t@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190711181521.fqsbatc2oslo2v5t@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 11-07-19 20:15:21, Pali Rohár  wrote:
> On Thursday 11 July 2019 08:38:51 Steven J. Magnani wrote:
> > --- a/fs/udf/super.c	2019-07-10 18:57:41.192852154 -0500
> > +++ b/fs/udf/super.c	2019-07-10 20:47:50.438352500 -0500
> > @@ -685,16 +685,62 @@ out_unlock:
> >  	return error;
> >  }
> >  
> > -/* Check Volume Structure Descriptors (ECMA 167 2/9.1) */
> > -/* We also check any "CD-ROM Volume Descriptor Set" (ECMA 167 2/8.3.1) */
> > -static loff_t udf_check_vsd(struct super_block *sb)
> > +static int identify_vsd(const struct volStructDesc *vsd)
> > +{
> > +	int vsd_id = 0;
> > +
> > +	if (!strncmp(vsd->stdIdent, VSD_STD_ID_CD001, VSD_STD_ID_LEN)) {
> 
> Hi! You probably want to use memcmp() instead of strncmp().

There's no difference in functionality but I agree it makes more sense.
I'll modify the patch. Thanks for review!

								Honza

> 
> > +		switch (vsd->structType) {
> > +		case 0:
> > +			udf_debug("ISO9660 Boot Record found\n");
> > +			break;
> > +		case 1:
> > +			udf_debug("ISO9660 Primary Volume Descriptor found\n");
> > +			break;
> > +		case 2:
> > +			udf_debug("ISO9660 Supplementary Volume Descriptor found\n");
> > +			break;
> > +		case 3:
> > +			udf_debug("ISO9660 Volume Partition Descriptor found\n");
> > +			break;
> > +		case 255:
> > +			udf_debug("ISO9660 Volume Descriptor Set Terminator found\n");
> > +			break;
> > +		default:
> > +			udf_debug("ISO9660 VRS (%u) found\n", vsd->structType);
> > +			break;
> > +		}
> > +	} else if (!strncmp(vsd->stdIdent, VSD_STD_ID_BEA01, VSD_STD_ID_LEN))
> > +		vsd_id = 1;
> > +	else if (!strncmp(vsd->stdIdent, VSD_STD_ID_NSR02, VSD_STD_ID_LEN))
> > +		vsd_id = 2;
> > +	else if (!strncmp(vsd->stdIdent, VSD_STD_ID_NSR03, VSD_STD_ID_LEN))
> > +		vsd_id = 3;
> > +	else if (!strncmp(vsd->stdIdent, VSD_STD_ID_BOOT2, VSD_STD_ID_LEN))
> > +		; /* vsd_id = 0 */
> > +	else if (!strncmp(vsd->stdIdent, VSD_STD_ID_CDW02, VSD_STD_ID_LEN))
> > +		; /* vsd_id = 0 */
> > +	else {
> > +		/* TEA01 or invalid id : end of volume recognition area */
> > +		vsd_id = 255;
> > +	}
> > +
> > +	return vsd_id;
> > +}
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
