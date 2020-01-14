Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1AC513A8E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 13:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgANMBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 07:01:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:40614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgANMBk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:01:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC840AE34;
        Tue, 14 Jan 2020 12:01:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5544B1E0D0E; Tue, 14 Jan 2020 13:01:38 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:01:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [WIP PATCH 1/4] udf: Do not access LVIDIU revision members when
 they are not filled
Message-ID: <20200114120138.GH6466@quack2.suse.cz>
References: <20200112175933.5259-1-pali.rohar@gmail.com>
 <20200112175933.5259-2-pali.rohar@gmail.com>
 <20200113120049.GF23642@quack2.suse.cz>
 <20200113183728.ucuidmverddt4nme@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113183728.ucuidmverddt4nme@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-01-20 19:37:28, Pali Rohár wrote:
> On Monday 13 January 2020 13:00:49 Jan Kara wrote:
> > On Sun 12-01-20 18:59:30, Pali Rohár wrote:
> > > minUDFReadRev, minUDFWriteRev and maxUDFWriteRev members were introduced in
> > > UDF 1.02. Previous UDF revisions used that area for implementation specific
> > > data. So in this case do not touch these members.
> > > 
> > > To check if LVIDIU contain revisions members, first read UDF revision from
> > > LVD. If revision is at least 1.02 LVIDIU should contain revision members.
> > > 
> > > This change should fix mounting UDF 1.01 images in R/W mode. Kernel would
> > > not touch, read overwrite implementation specific area of LVIDIU.
> > > 
> > > Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
> > 
> > Maybe we could store the fs revision in the superblock as well to avoid
> > passing the udf_rev parameter?
> 
> Unfortunately not. Function udf_verify_domain_identifier() is called
> also when parsing FSD. FSD is stored on partition map and e.g. Metadata
> partition map depends on UDF revision. So it is not a good idea to
> overwrite UDF revision from FSD. This is reason why I decided to use
> initial UDF revision number only from LVD.
> 
> But whole stuff around UDF revision is a mess. UDF revision is stored on
> these locations:
> 
> main LVD
> reserve LVD
> main IUVD
> reserve IUVD
> FSD
> 
> And optionally (when specific UDF feature is used) also on:
> 
> sparable partition map 1.50+
> virtual partition map 1.50+
> all sparing tables 1.50+
> VAT 1.50
> 
> Plus tuple minimal read, minimal write, maximal write UDF revision is
> stored on:
> 
> LVIDIU 1.02+
> VAT 2.00+
> 
> VAT in 2.00+ format overrides information stored on LVIDIU.

Thanks for the summary. This is indeed a mess in the standard so let's not
overcomplicate it. I agree with just taking the revision from 'main LVD'
and storing it in the superblock like you do in this patch. I'd just
slightly change your code so that extracting a revision from 'struct regid'
is a separate function and not "hidden" inside
udf_verify_domain_identifier(). There's no strong reason for combining
these two.

WRT parsing of minUDFReadRev and friends, I'd handle them similarly to
numDirs and numFiles. I'd initialize them to the version we've got from
LVD, then possibly override them in udf_load_logicalvolint(), and finally
possibly override them in udf_load_vat().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
