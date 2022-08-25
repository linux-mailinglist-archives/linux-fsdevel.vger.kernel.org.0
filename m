Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C23D5A0807
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 06:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiHYEd6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 00:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiHYEd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 00:33:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2400B87683;
        Wed, 24 Aug 2022 21:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661402035; x=1692938035;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5HXZk3iG3sPQn07M7WNhsFWEiUsLw3xfxBKA55hnYyE=;
  b=dBEFWos0bF5SVzruhnuBKbUZXcaUJKkn6HhJvqxcMrt9g1qC9fZTlFug
   tFxaH2BGoBCsY8HCn7EaL38bggsv9XzXwheNgneyHfNhCTi58580VGfbq
   3bYaclEUt3AO3QB86o13k4QpxBRrJE3FyDKzMGAy/Qhfnvqdn07KvfupD
   Zs4P0KaMe9Soga9rGAusHrCAs6YrfEJtu2wwtP8n7WxLyPDlirMCPAj43
   +M37zUgLfuNLpdPI43lOLD8c+m5MnBEnEE+/xjlrcCnMYQBYSfa5CTx/j
   A9uNsejZsGEukrFS2tPbMRvtdMoPebx/W+ZwhNdf8oSkhjpTw5W4mElBp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="380434132"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="380434132"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 21:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="586712758"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2022 21:33:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 21:33:53 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 21:33:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 21:33:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 21:33:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbZOkyCbZe5NZHVYMl1bUzhM05Jo1obU5ClAtM8SIHNVVeP8ez55EPoBpiqsLMZWCj91wg0RT7RGiGSHYAwnwRdgxmuRGIVhglC0y/WwrzSZ2wfeGe33AzENcR49UgEJM/g2hwROaLg/KW0vWhAM/1PXcNNuejWZhZavMR8lPwYYcc709G4U3TEZTUql5omK1AYx38OPDIg/IiR/VvzYw0YsCQ1zjTxwBlWEIa9KFN07+5aLzfoeyeH1njAa2MmcdvgmLnYITK37OvcdTdAY1Tp29NEfMDSTXKLdITXNwYC6ZtJgnJw5UhBS2OVsA6rM7mwp7P+NTzEqXfAvaFpGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8B0/KE6F2ahdiPYJpMklN6aUhdce3gKZLkSU6PjWRQ=;
 b=g4wrpYvq3NCYQeWczCmea46KDMAlX9lAWUmbmrNGRSiBjTXYUaumBam0ze4H3hBAe3u6ec32km7wBVSgelEEuT2hXHnLJhJjrBllumvJPB9gPtgFD4VGzQSZ39ONYgbriizp1EAGLn1U34VgGvwbduIPXulGJY+nTTRQBz72SkvYLEdcnva1VdO38j2ww77Dukbes1JIqA2CrsAishpZZEKOwHPEcsy6bvQRPIWLw0s/FzRtCdlK6RiVwAe0GrBRXL8AQmVYZcy6sj262R4qmVZM6+vd+7oTrnb5GtFYeWGb5VMGO4hsiaahk9/3/StUcAMOLCgulUaPSeZ6IqRR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM5PR11MB1627.namprd11.prod.outlook.com
 (2603:10b6:4:a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 04:33:51 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5546.024; Thu, 25 Aug 2022
 04:33:50 +0000
Date:   Wed, 24 Aug 2022 21:33:47 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 05/14] mm: Introduce mf_dax_kill_procs() for fsdax case
Message-ID: <6306fbabab4cd_18ed7294e2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
 <20220603053738.1218681-6-ruansy.fnst@fujitsu.com>
 <63069db388d43_1b3229426@dwillia2-xfh.jf.intel.com.notmuch>
 <20220824234142.GA850225@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220824234142.GA850225@hori.linux.bs1.fc.nec.co.jp>
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5faca4e3-ec91-4dfe-eb48-08da86530259
X-MS-TrafficTypeDiagnostic: DM5PR11MB1627:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UF3siTIB1Ron7I7YDi4XMlh1g9mIPHLih3PeOqHCSw5h8AcfxgV1D0GKVUtvwHsPruIJxICgLoJpNDKgQcXLNBcfyBWDfDvCGrBGEZHPKN0hFMol+qKhsLo5ohIkrsHFJWIWaNxaqL2tO0E07NzlzkCqGhPPtwYpMw1b1WSqKMmupl4j5FuuZy6F0DB8UG4drmQ2TSbROLMcb20L5J1owk5Co8nQh84GqAv3DCo8rvuYgB2vpdpj6fszsVHEWHo/pTI0qRsy1zXKata99rigNB1uATboVLza4gMHcv0S4DRv6kJVGwrm0SFCk6Ki+WO2ZeQa3EcUF/CTkdGCyADsRatI5G2wCkTOq5YgmLgQQtR2TorsCrFZtzrmsuVcP1KaGHi/alcfVr4x2eNH9GB4a3U5Nod/FYTyiIxDZAThcF32oBrWZFs9Gm6DGfhviXDjXnKYSQZe56N4Av8HFjm0xdwITpuZzeAkAnQ6kuAFaRMGHP45ROQXZg6el3gWatLj5PNUGMxQTA1Ir06IJDT1XVQlJCbPNrRNHV1CGwLjcd0pIRscfoMEfbwiOAktWL8oMr/xk/6dQhMDpMAUsi/PXm60nbHrdNcNlDuIPt8CPyYjSkVtOSF/MITBNJrQRCAhglp/+l7/fXCoSBiq/NIyfx+QrpxALNDOM1jbKQaQ2j+KWYpkRi/RwUb8onDxEzZaanF+X28kCetnpeIuI+oxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(346002)(136003)(376002)(186003)(41300700001)(6666004)(6512007)(26005)(9686003)(86362001)(82960400001)(6506007)(6486002)(83380400001)(478600001)(54906003)(66946007)(66556008)(8676002)(110136005)(66476007)(4326008)(316002)(38100700002)(5660300002)(8936002)(7416002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVBVQnNLd2hERzZrNnJFdEhkWUpZQitCZWx4d2pHTjl5Y1J6eUdpRklmQkJH?=
 =?utf-8?B?ZC9nZU43Mmh6ZGUrSitLMWdlYjZ1aVBGcWFBWmZWMVNweEpzWkF3bUp3TVVi?=
 =?utf-8?B?clV6SUo2N0tyNXF0b1AxVkM2SUZBbDRzV0VKQ29Fcmx4cGJrSVN3cnRBMUll?=
 =?utf-8?B?RFNSMEJWTnVNY0F2V1pNRVltZ2x4cThBNkxTNDNtT1FDTGxQNU9KMmc4NVlq?=
 =?utf-8?B?cHlWUWNwSUZOWm55ajJsemh6dlV2RE1OUHJRSFQ3R2lPNTQydGJPNGI0MWw4?=
 =?utf-8?B?NDhTQUNGNEtvU3BTSDlZMnZQbHEvb0gxcVBmay9ucEFaR1VVeVNPKzVZdmtn?=
 =?utf-8?B?cHArbS81anJ1Q2lUaHRUQzNpdzFhcW0rVURuVEFDeENOWldrdVhvdHZ2eEpZ?=
 =?utf-8?B?MmxKdlBXNEdVMDBxbkRGQ0p3SnN5Zit1RkdadUVFSHU5YkJkcVJqb2hFdGFS?=
 =?utf-8?B?ZCtTUDlZVjduWmVvT092RGdkbHUwRVgyNTFNWUw0MGhLZTZSRUJxbXlZVlVT?=
 =?utf-8?B?SnNBaFhybDFzVXluTUY1SWVRZ1NzV3BhaHhBRVFubEwrMHNBS0xNR2xRbmsw?=
 =?utf-8?B?MVpQVzFRSzhOUFk5SlFxdUNKNjZvVUd0eWY2Y0M0azFwdVB5c0dDaXNLc2Z6?=
 =?utf-8?B?cmNWMjhmVmRXL1B5enZnTkFYZVpXSUd0bm1LT0RQM2h6ZVN2cnN6OGtpNW9q?=
 =?utf-8?B?bGlXcFp1cERTRVRvYkpKUWJCSE9uTjlZWW5WbGl3amRkOG5UcitYT2Z2K3pu?=
 =?utf-8?B?TXBBdExQNEtZWVNadzZ6U0lUSkJKQWZNVm5tQlpCR012c3ZJSkYxS2ptTHVD?=
 =?utf-8?B?NmJpcG9SUDFGeWlhNnovdzBHNVRKSG9FeWVJbDNXbDU1aEFMR3NSQ3ZTenJE?=
 =?utf-8?B?RURTNUR1UDRpRFZ5WENqZmcrdlhENzg2SUFNNGdJdlFJL2dHeFJ5N3FNaHlP?=
 =?utf-8?B?eXZkbFduSzdRSkxURDhxbENaSnJKcUxYdWY5c1piamMyM3NEVVBaMzZYZ2pi?=
 =?utf-8?B?cjVBQTB0d01OY0tLMGtYVmlSNmVBcHZXbHk0WkF0ck5kWkwrVzJhT0YxekZ4?=
 =?utf-8?B?UUJBMjNoM0ZDOXJYcDlVQTY0NitSNEo5TG91THk0ZXNXT2p1UkZDL280bncw?=
 =?utf-8?B?YWx5emxkY0JyUnk5S0dWeW03aUIrTE9XVU1VLzdNcFcrdnJuSkUzWXJNOUNZ?=
 =?utf-8?B?My9VTklqYTlKcHZmQXVnUkRMQnUyeXMwc1NaWWhaajJHS3JIL1BYZVBTTEZM?=
 =?utf-8?B?S2NPNm1YNTk0cElHY29BQTdqMjFrZHdQTUtVRU0wdlZBWFRQVUMzVU5Vc3g0?=
 =?utf-8?B?OHhzaGRIQjRVWkxFODUyRk5sdUU5dDJzQVFpRkJZV2xOdmdyQlZoWGp3Q0dT?=
 =?utf-8?B?Uk5kczk0QTdBNnVQVktsQllRUEw4NGVwSFQyUGZNZmZWOExNNFZ4aVR4N2dS?=
 =?utf-8?B?MTN1UDlwNm5DblpsMWUwcjRDUzJVTTNNM0lYN2N1L2lPNTJhT3V3Z2lubzR0?=
 =?utf-8?B?U3JvRUdlTm5ySWR3UDU0bHJ4NXlreGZUOFYrdHBNQUhvT1ZNQlo3N0VKa1V6?=
 =?utf-8?B?Sm1XYzNaeHlMdXQvdURMNG54TjdBNWNTSDFOSzE3ZlVIS1NQdWlnbDU2NjhI?=
 =?utf-8?B?RU1Vd3pybVhLZ3hSOGZVVVhVNVlqZy96ejUrdkJEMzJWUzlaRkpwKzdEWVNS?=
 =?utf-8?B?Nm5jc0RSTDJSSnJ0QWxXUE5GOHlSckU3SCtHb3BqcjNUU3ZIbnl3SjBRU0tY?=
 =?utf-8?B?VUh0eFlWd1dRaFU5VVRFdUJuZzBzZnJNRFpWR0d0NHlrdEo4ZUF6WmxabmNa?=
 =?utf-8?B?QUNXb0pJU3Q3eTcwWW1RRDJjeUdVVVNUTlM1a3ZkUGhycTVSK2RxbGlnZ3lE?=
 =?utf-8?B?c001cS9raVZncGUxdkw2VHo5bDFleDJCaVBnOGNMRzM3WHBaY0JDdE56VGtT?=
 =?utf-8?B?Y3UrYjA1YlhaRjhIZ3ZaaXUvUWFhcVNnSnZMdUF6a0hHaEhqdk56S3VMMnA4?=
 =?utf-8?B?VFczeGI0WUJWcWNnQnhXUUNhUVdHSlMydm5MS1o3YTY1S1FaSkpUQVA4aU9F?=
 =?utf-8?B?ekw4Q25wUE1lZjliSGlieDdEMHlDckwzdm5zdkhXSVlacTBUdWpvTFRFS2Yw?=
 =?utf-8?B?YkJtcVhrZW9zbVA0WTB0ZXBVcUJWSGh5bWhZTUkwb3JEcGROUmhxdWxUYUMv?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5faca4e3-ec91-4dfe-eb48-08da86530259
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 04:33:50.8544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVpIkc4qttmGWxLYjkIR/rMlwUJmClp01xA9epVYTO8xwhkJustnZoVsn9tMM0zzaPrJ5lWZxqOc2M6pWwhtc8vjHLAz9z69Cfar4zVS+qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1627
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

HORIGUCHI NAOYA(堀口　直也) wrote:
> On Wed, Aug 24, 2022 at 02:52:51PM -0700, Dan Williams wrote:
> > Shiyang Ruan wrote:
> > > This new function is a variant of mf_generic_kill_procs that accepts a
> > > file, offset pair instead of a struct to support multiple files sharing
> > > a DAX mapping.  It is intended to be called by the file systems as part
> > > of the memory_failure handler after the file system performed a reverse
> > > mapping from the storage address to the file and file offset.
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> > > ---
> > >  include/linux/mm.h  |  2 +
> > >  mm/memory-failure.c | 96 ++++++++++++++++++++++++++++++++++++++++-----
> > >  2 files changed, 88 insertions(+), 10 deletions(-)
> > 
> > Unfortunately my test suite was only running the "non-destructive" set
> > of 'ndctl' tests which skipped some of the complex memory-failure cases.
> > Upon fixing that, bisect flags this commit as the source of the following
> > crash regression:
> 
> Thank you for testing/reporting.
> 
> > 
> >  kernel BUG at mm/memory-failure.c:310!
> >  invalid opcode: 0000 [#1] PREEMPT SMP PTI
> >  CPU: 26 PID: 1252 Comm: dax-pmd Tainted: G           OE     5.19.0-rc4+ #58
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> >  RIP: 0010:add_to_kill+0x304/0x400
> > [..]
> >  Call Trace:
> >   <TASK>
> >   collect_procs.part.0+0x2c8/0x470
> >   memory_failure+0x979/0xf30
> >   do_madvise.part.0.cold+0x9c/0xd3
> >   ? lock_is_held_type+0xe3/0x140
> >   ? find_held_lock+0x2b/0x80
> >   ? lock_release+0x145/0x2f0
> >   ? lock_is_held_type+0xe3/0x140
> >   ? syscall_enter_from_user_mode+0x20/0x70
> >   __x64_sys_madvise+0x56/0x70
> >   do_syscall_64+0x3a/0x80
> >   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> This stacktrace shows that VM_BUG_ON_VMA() in dev_pagemap_mapping_shift()
> was triggered.  I think that BUG_ON is too harsh here because address ==
> -EFAULT means that there's no mapping for the address.  The subsequent
> code considers "tk->size_shift == 0" as "no mapping" cases, so
> dev_pagemap_mapping_shift() can return 0 in such a case?
> 
> Could the following diff work for the issue?

This passes the "dax-ext4.sh" and "dax-xfs.sh" tests from the ndctl
suite.

It then fails on the "device-dax" test with this signature:

 BUG: kernel NULL pointer dereference, address: 0000000000000010
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 8000000205073067 P4D 8000000205073067 PUD 2062b3067 PMD 0 
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 22 PID: 4535 Comm: device-dax Tainted: G           OE    N 6.0.0-rc2+ #59
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 RIP: 0010:memory_failure+0x667/0xba0
[..]
 Call Trace:
  <TASK>
  ? _printk+0x58/0x73
  do_madvise.part.0.cold+0xaf/0xc5

Which is:

(gdb) li *(memory_failure+0x667)
0xffffffff813b7f17 is in memory_failure (mm/memory-failure.c:1933).
1928
1929            /*
1930             * Call driver's implementation to handle the memory failure, otherwise
1931             * fall back to generic handler.
1932             */
1933            if (pgmap->ops->memory_failure) {
1934                    rc = pgmap->ops->memory_failure(pgmap, pfn, 1, flags);


...I think this is just a simple matter of:

@@ -1928,7 +1930,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
         * Call driver's implementation to handle the memory failure, otherwise
         * fall back to generic handler.
         */
-       if (pgmap->ops->memory_failure) {
+       if (pgmap->ops && pgmap->ops->memory_failure) {
                rc = pgmap->ops->memory_failure(pgmap, pfn, 1, flags);
                /*
                 * Fall back to generic handler too if operation is not


...since device-dax does not implement pagemap ops.

I will see what else pops up and make sure that this regression always
runs going forward.
