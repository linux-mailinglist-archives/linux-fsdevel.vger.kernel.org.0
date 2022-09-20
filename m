Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB35BEB4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 18:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiITQpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 12:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiITQpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:45:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C7A14029;
        Tue, 20 Sep 2022 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663692299; x=1695228299;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SwZAVtmv557URZ+Ud5sixxV1LFPXBL7n7iPtBR0CqB4=;
  b=dgAVFpvoReAQPI5rQPwkAO6xuLlR5FDX8K9d5nSCze6WrMO+u3ejtGAf
   2RPeVqTuXvXBH3XlEp4Vc109c0yj0cTB1N37M2wCJG4LEIST4hA3nMqtN
   K6zGMkbno0zd/tZoPK6WLnJBotOIehUhrDcG65ggFKfhYK3Lfg7ZjdjQZ
   6lr+vkg18m/1quoxekdU5Ba3vK9ylFUNwSThpfjHrOGnyk6N5EklVHt+X
   u7hmYEqTQC3m21g0jzCGmSY8Nc/+/nKfdMghobzIBoNK0qsbgEpt4+F8Q
   RjT+90y86w2EOt8f7XcKosH/3JQOzEeMwepbjzhqy257b9qnlDFowAmfG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="326058147"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="326058147"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 09:44:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="618978728"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 20 Sep 2022 09:44:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 09:44:58 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 09:44:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 09:44:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 09:44:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGBodfw2huVmkWncqv9czxY1MOUf4ktM0jN8X7fblnoNFoYvyGkK/VPZGEDnxfAH+BNbQAqGr4IhCKb9+0rDhu6rTCkgeucHcGY19wf6GcOtDwBZ8IRDyBYFiax1DpvfbvnUk80ruJSkMLFkonfS+FuQoFIOO2nUe7BQpgxxeolQcBPxzN+B7SnXDzNzRlcQmbo1YYHtK7jmSpbY9fUkkKEL6AiiHd9erTaIlj/LpfstAZyaBNwxv7osLGnHHTDhFE/eDr6Wn/2J9zqUPoNbPxbNULa5sLjCs6xV3YYaI0vXxwlSjO2ow2CCkYLvVXXQ1GvXcMp1P0UmyuDDoi6Zog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B28IJM1Vgv2KTOEAnbSgAwquXlOVRz6pWbbkvJpyy9k=;
 b=A5Hc//rFMmhzVgND2ui2h+9ShtWyTUXDoBbgnS3fBac0FNVw7Q8yEcdNF36hhbCTcvS3yMBCzE+Qu++stkao7PN6leu0qKKqAZXfvNMSl/y/VeUjrrjiltsd2cITKlroO2IPRu5eFhknGCNLNdzpFVtvrWdZFyb/ni3MKdQhDbdTixkXE5vUieEK1cwvilhFSeRpp9wqALcOIvBETA5OgfHr26gwlEi3/s/T5S6LjhZ1goxTYSHIiODPtB5xzRT47Z0+ftbVZPgqBm+lQwU3+SSu7IDSzvugC2lGvengZo+tHvB3+cbezMnDKQ2f6Fjiw+ztSWwbEoRl8TKeSPJyGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB7092.namprd11.prod.outlook.com
 (2603:10b6:806:29b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Tue, 20 Sep
 2022 16:44:56 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 16:44:56 +0000
Date:   Tue, 20 Sep 2022 09:44:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Chinner <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        "Jan Kara" <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329933874.2786261.18236541386474985669.stgit@dwillia2-xfh.jf.intel.com>
 <20220918225731.GG3600936@dread.disaster.area>
 <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220919212959.GL3600936@dread.disaster.area>
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ecfa690-a4fa-454a-58a7-08da9b2772aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1xzaTygrnwi03TzNeiNLhwmTgZwYuNrv6sHz1WeBo5JeKrFiykMxzbFu4CxJOK4DbXNpXdbrZM/zTMH1V0YmsACVqzBRe9kqn/8cVCb/Ac5Nb0/CVjsw37YEiNrEp9hd3LOiMHcYqbuCQw2vwoLft6F+Mxzbp37DtSSSbeVr2MvLMsaC1DYCXA3pQTgUoKOyRVARR9HQFTYos0sC2QGiwSYjLcN8IIU3NLELIgh6nPx6RtgZ7sup1DIRKmTYtBmDtncesip62yZ31wqB33CEw2HujFOu48bRGzbXkBystrBcOQfI1/v1flmrqC/IwGSB5gKlWVu0iU4J0Ol8xZrcZmHs9q0Co7Yc5xyTuy522vcJMa+PxUfYt5+4KwYuYVTlPokZsNoLwDhx5zW+4rDJgqEMiO223U7ddnS7Eyxx3cIXKFnxDWY0sKsQEZo1Jubb1SpResQ1zEIb4deKNa3oa/WzawLi3khLSm7acgXVbtBcWDeLYlAHEtUoDlYgN6DCKFByWDj8t1g7qlui46EAVWkJgSaza1UVPFhs/qgEGF++/LwYew7aRAbTmu4HvY3Ykt8FczWVUvxoTsg10HE+LEvGjUa+4CC3KYmK2yu8xsXIN0JCQLa6ZxtnzyP7VYMEOuT92e4Z55AMhbNpYAAAGgvj10eTHUsAP5vsWWRqQb8d1MYdiWIexsKTVp+nvo3gz7Cj4fwtCrrdhnZyOicLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(26005)(6512007)(9686003)(6506007)(8676002)(7416002)(82960400001)(66946007)(478600001)(6486002)(5660300002)(38100700002)(2906002)(66476007)(186003)(6666004)(41300700001)(83380400001)(4326008)(86362001)(66556008)(316002)(54906003)(8936002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RrzhfptgIjy0w5nkRMqa3vu++Hn9s3YdAbjrTBpHdlzk2ofsFF8nyAzvltJD?=
 =?us-ascii?Q?5yb72cicfqG75jf1G1gDa8hRqpjVBfd21FjcfGQMtm35qT1HX5/vO07DGmab?=
 =?us-ascii?Q?S2Rh56lRLDFJ4+NRJlFy0JwYwlNZHjpLXlOQONIdrSEzF/tNY7YgSe0kfyAl?=
 =?us-ascii?Q?2f9jOir7BQb9QvQD+BiRiTWnkdwDm/E8PTM4XH3ROcus0Bd8KK8FcK7lbk/A?=
 =?us-ascii?Q?5DWnnWSI8ZndLF+qbkgP7ovNaO5PNY6LWnkHQzhJVU5+FgBLaJv+jcfJ9Vza?=
 =?us-ascii?Q?hs2O/uFLVCDx6O7IAFM3iEuNCzWjNAkj/hgT6GcyxzjSCHsqbILQ2fR92Sv0?=
 =?us-ascii?Q?LF/S/J0cmB3+wMb1PcDs0wRoQ6FBVM3aM6pFHwKkQGjBQxtYMUdlJaB+lILX?=
 =?us-ascii?Q?B9MBDk2sKnSPu34C3G0fbnETGCARGZ/Qlkq9mE6Z+J29ZbYO95tb/We4wzEo?=
 =?us-ascii?Q?lMU03LHYXDlE2kTYuTUHseoE17ZzHR2zAYRydBE+R3KGMEa1KNcWTz+vcF9B?=
 =?us-ascii?Q?GT34JSKkdN5KxvjBlrQTCFTfEB5Znqm4CjGc6GOJQS8EjIL7ZfdU6qUk3IM9?=
 =?us-ascii?Q?6RY6EYJmx+8U+RTK+e+JEmgA9LtRALqaaPuPIjegFWgQBweEBII8zk4bY8hW?=
 =?us-ascii?Q?e1JFCxZgvVbMzuGFFPLgt5tY95edaD1PFSG3/BZrWm6xiMshW2Ogo0xCg+Bs?=
 =?us-ascii?Q?3fEpYvC1bXjW8AUsTS9ZbGRAO/Oc3sxria6f9g1JnFJ4bw1cK7XsQXMDpwMY?=
 =?us-ascii?Q?FFUsqKxK9k51CH+D7v1gKdcMKfXmsd3vFsyvNoJyXPilQLZsPKZIfEFfjNV7?=
 =?us-ascii?Q?mpQy0LSNEJ52hsrYN7X3521yVNSeGwf9MKWVZnFumgXIP5f0OQiEMSdFHUkA?=
 =?us-ascii?Q?ecpPCVES+mem5zjpVRPJ5LSLQHPkDh340agJ8CVsxGfx6wO3nEC1kIDeVwLQ?=
 =?us-ascii?Q?6/21jautINMdUxPz0Yr3oixh2oMnaJ1XmZbc9idFSeUO8mXy74Lg7dQCxrsm?=
 =?us-ascii?Q?2gLczDK+3Oc3ELhawfKtZiZvBDtnsKkbgJ0nxGiepTg5efEn9sKrmkqOFcrr?=
 =?us-ascii?Q?u8SxONk/Jl2X0ybAYrgsPSrGydUAgfv0WNd3vzFf2mfjzPfIzdsbMKta65go?=
 =?us-ascii?Q?0F2zO0KTDKmOISx2Mog1ti4XKmarRgGpyDxFbPwaUvfsQhsD/lFd1FmzzyTH?=
 =?us-ascii?Q?IWq1KcP6q6cDkEIVQZhUbyLESyEFsQi2gsNfzxWupcuQqAM+CQi5+UeHjE2a?=
 =?us-ascii?Q?aZhjC6vA54E3wY1SahlqehZOGHMVJwZKOX5s38rMOTwWRe0y90CPI0gKEDbQ?=
 =?us-ascii?Q?/6TBFl3KiWQYLP7BZgKKYnHf/LNs1SdrBKrKss7H4vjJueaZtv+ZdB8Q1h6g?=
 =?us-ascii?Q?uXLalOiq5uMZQbJr/anroJpRb07zTTKgmhOBXzI3NUeanmDMoRJ4qP+Anji8?=
 =?us-ascii?Q?e419bcuDyQbU6twmfH8Q5SSilnuOUImjU4NWaRtgtXG9xKMBxjC2VjwIszNj?=
 =?us-ascii?Q?ZXwMdgMmKN2YFFbRamifW65dWF4+IOKwJTwGEeELJz+bHNijjsQAu3dPzJoi?=
 =?us-ascii?Q?PKI81rUh3aR4NUoWesetFPa0BtVdSEjQ18TH/I+Ln9ZGv0qSXkmyIDhqq3ax?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecfa690-a4fa-454a-58a7-08da9b2772aa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 16:44:56.0204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6CnmtZ/BF505GImRiMfsnsM7LRl0Z+bMpOPGQcT7xITwpUovawhQJ5F4tyyiaJwN95sJMhNu62H+VAmXVeVY9MIq933K6eTxJ1hhnNzCxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7092
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner wrote:
> On Mon, Sep 19, 2022 at 09:11:48AM -0700, Dan Williams wrote:
> > Dave Chinner wrote:
> > > On Thu, Sep 15, 2022 at 08:35:38PM -0700, Dan Williams wrote:
> > > > In preparation for moving DAX pages to be 0-based rather than 1-based
> > > > for the idle refcount, the fsdax core wants to have all mappings in a
> > > > "zapped" state before truncate. For typical pages this happens naturally
> > > > via unmap_mapping_range(), for DAX pages some help is needed to record
> > > > this state in the 'struct address_space' of the inode(s) where the page
> > > > is mapped.
> > > > 
> > > > That "zapped" state is recorded in DAX entries as a side effect of
> > > > xfs_break_layouts(). Arrange for it to be called before all truncation
> > > > events which already happens for truncate() and PUNCH_HOLE, but not
> > > > truncate_inode_pages_final(). Arrange for xfs_break_layouts() before
> > > > truncate_inode_pages_final().
> ....
> > > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > > index 9ac59814bbb6..ebb4a6eba3fc 100644
> > > > --- a/fs/xfs/xfs_super.c
> > > > +++ b/fs/xfs/xfs_super.c
> > > > @@ -725,6 +725,27 @@ xfs_fs_drop_inode(
> > > >  	return generic_drop_inode(inode);
> > > >  }
> > > >  
> > > > +STATIC void
> > > > +xfs_fs_evict_inode(
> > > > +	struct inode		*inode)
> > > > +{
> > > > +	struct xfs_inode	*ip = XFS_I(inode);
> > > > +	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
> > > > +	long			error;
> > > > +
> > > > +	xfs_ilock(ip, iolock);
> > > 
> > > I'm guessing you never ran this through lockdep.
> > 
> > I always run with lockdep enabled in my development kernels, but maybe my
> > testing was insufficient? Somewhat moot with your concerns below...
> 
> I'm guessing your testing doesn't generate inode cache pressure and
> then have direct memory reclaim inodes. e.g. on a directory inode
> this will trigger lockdep immediately because readdir locks with
> XFS_IOLOCK_SHARED and then does GFP_KERNEL memory reclaim. If we try
> to take XFS_IOLOCK_EXCL from memory reclaim of directory inodes,
> lockdep will then shout from the rooftops...

Got it.

> 
> > > > +
> > > > +	truncate_inode_pages_final(&inode->i_data);
> > > > +	clear_inode(inode);
> > > > +
> > > > +	xfs_iunlock(ip, iolock);
> > > > +}
> > > 
> > > That all said, this really looks like a bit of a band-aid.
> > 
> > It definitely is since DAX is in this transitory state between doing
> > some activities page-less and others with page metadata. If DAX was
> > fully committed to behaving like a typical page then
> > unmap_mapping_range() would have already satisfied this reference
> > counting situation.
> > 
> > > I can't work out why would we we ever have an actual layout lease
> > > here that needs breaking given they are file based and active files
> > > hold a reference to the inode. If we ever break that, then I suspect
> > > this change will cause major problems for anyone using pNFS with XFS
> > > as xfs_break_layouts() can end up waiting for NFS delegation
> > > revocation. This is something we should never be doing in inode
> > > eviction/memory reclaim.
> > > 
> > > Hence I have to ask why this lease break is being done
> > > unconditionally for all inodes, instead of only calling
> > > xfs_break_dax_layouts() directly on DAX enabled regular files?  I
> > > also wonder what exciting new system deadlocks this will create
> > > because BREAK_UNMAP_FINAL can essentially block forever waiting on
> > > dax mappings going away. If that DAX mapping reclaim requires memory
> > > allocations.....
> > 
> > There should be no memory allocations in the DAX mapping reclaim path.
> > Also, the page pins it waits for are precluded from being GUP_LONGTERM.
> 
> So if the task that holds the pin needs memory allocation before it
> can unpin the page to allow direct inode reclaim to make progress?

No, it couldn't, and I realize now that GUP_LONGTERM has nothing to do
with this hang since any GFP_KERNEL in a path that took a DAX page pin
path could run afoul of this need to wait.

So, this has me looking at invalidate_inodes() and iput_final(), where I
did not see the reclaim entanglement, and thinking DAX has the unique
requirement to make sure that no access to a page outlives the hosting
inode.

Not that I need to tell you, but to get my own thinking straight,
compare that to typical page cache as the pinner can keep a pinned
page-cache page as long as it wants even after it has been truncated.
DAX needs to make sure that truncate_inode_pages() ceases all access to
the page synchronous with the truncate. The typical page-cache will
ensure that the next mapping of the file will get a new page if the page
previously pinned for that offset is still in use, DAX can not offer
that as the same page that was previously pinned is always used.

So I think this means something like this:

diff --git a/fs/inode.c b/fs/inode.c
index 6462276dfdf0..ab16772b9a8d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -784,6 +784,11 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
                        continue;
                }
 
+               if (dax_inode_busy(inode)) {
+                       busy = 1;
+                       continue;
+               }
+
                inode->i_state |= I_FREEING;
                inode_lru_list_del(inode);
                spin_unlock(&inode->i_lock);
@@ -1733,6 +1738,8 @@ static void iput_final(struct inode *inode)
                spin_unlock(&inode->i_lock);
 
                write_inode_now(inode, 1);
+               if (IS_DAX(inode))
+                       dax_break_layouts(inode);
 
                spin_lock(&inode->i_lock);
                state = inode->i_state;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..e4a74ab310b5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3028,8 +3028,20 @@ extern struct inode * igrab(struct inode *);
 extern ino_t iunique(struct super_block *, ino_t);
 extern int inode_needs_sync(struct inode *inode);
 extern int generic_delete_inode(struct inode *inode);
+
+static inline bool dax_inode_busy(struct inode *inode)
+{
+       if (!IS_DAX(inode))
+               return false;
+
+       return dax_zap_pages(inode) != NULL;
+}
+
 static inline int generic_drop_inode(struct inode *inode)
 {
+       if (dax_inode_busy(inode))
+               return 0;
+
        return !inode->i_nlink || inode_unhashed(inode);
 }
 extern void d_mark_dontcache(struct inode *inode);

...where generic code skips over dax-inodes with pinned pages.

> 
> > > /me looks deeper into the dax_layout_busy_page() stuff and realises
> > > that both ext4 and XFS implementations of ext4_break_layouts() and
> > > xfs_break_dax_layouts() are actually identical.
> > > 
> > > That is, filemap_invalidate_unlock() and xfs_iunlock(ip,
> > > XFS_MMAPLOCK_EXCL) operate on exactly the same
> > > inode->i_mapping->invalidate_lock. Hence the implementations in ext4
> > > and XFS are both functionally identical.
> > 
> > I assume you mean for the purposes of this "final" break since
> > xfs_file_allocate() holds XFS_IOLOCK_EXCL over xfs_break_layouts().
> 
> No, I'm just looking at the two *dax* functions - we don't care what
> locks xfs_break_layouts() requires - dax mapping manipulation is
> covered by the mapping->invalidate_lock and not the inode->i_rwsem.
> This is explicitly documented in the code by the the asserts in both
> ext4_break_layouts() and xfs_break_dax_layouts().
> 
> XFS holds the inode->i_rwsem over xfs_break_layouts() because we
> have to break *file layout leases* from there, too. These are
> serialised by the inode->i_rwsem, not the mapping->invalidate_lock.

Got it, will make generic helpers for the scenario where only
dax-break-layouts needs to be performed.
