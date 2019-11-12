Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 879AEF96B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 18:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfKLRKC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 12:10:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:29546 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbfKLRKC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:10:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 09:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="255751160"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Nov 2019 09:10:01 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 Nov 2019 09:10:01 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Nov 2019 09:10:01 -0800
Received: from crsmsx151.amr.corp.intel.com (172.18.7.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Nov 2019 09:10:01 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.94]) by
 CRSMSX151.amr.corp.intel.com ([169.254.3.96]) with mapi id 14.03.0439.000;
 Tue, 12 Nov 2019 11:09:59 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Dave Chinner" <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Subject: RE: [PATCH 2/2] fs: Move swap_[de]activate to file_operations
Thread-Topic: [PATCH 2/2] fs: Move swap_[de]activate to file_operations
Thread-Index: AQHVmPEJn03RPDacYEWb7WKbk7sMtKeHfu+AgABGKCA=
Date:   Tue, 12 Nov 2019 17:09:58 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E92BB4EFE@CRSMSX101.amr.corp.intel.com>
References: <20191112003452.4756-1-ira.weiny@intel.com>
 <20191112003452.4756-3-ira.weiny@intel.com>
 <20191112065507.GA15915@infradead.org>
In-Reply-To: <20191112065507.GA15915@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTM5NDE5MDYtMjAzNy00Nzc4LWEzYmEtNmZkNWU4YWQ2ZmM4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUEUrZUdXeGJIYm5OR3QzM0J0eTNySG1wRXZDTmw3OENZdDlmYkwzY1RoaFlMS1wvZTBGdWFhZTI3aDVoNG1icnMifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> On Mon, Nov 11, 2019 at 04:34:52PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > swap_activate() and swap_deactivate() have nothing to do with address
> > spaces.  We want to eventually make the address space operations
> > dynamic to switch inode flags on the fly.  So to simplify this code as
> > well as properly track these operations we move these functions to the
> > file_operations vector.
> 
> What is the point?  If we switch aops for DAX vs not we might as well switch
> file operations as well, as they pretty much are entirely different.

Obviously I was not clear enough.  The point is to have 2 fewer a_ops functions to worry about synchronizing.

I see Jan already replied.  So I'll leave it at that.

Ira

