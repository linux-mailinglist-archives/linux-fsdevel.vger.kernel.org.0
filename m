Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515776080D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 23:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJUVho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 17:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJUVhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:37:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7A22A6860;
        Fri, 21 Oct 2022 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666388260; x=1697924260;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=2ZvVMMrijqIdrx4498X3pVsno9utp1nDVStfPo8yVWA=;
  b=QH+R0J8KOCSc64a0k5vV5+F08NOPgsJWO2X8LJesgOoNseNr9GE6kR58
   btw8OcxZZQMGHx3/uzyPwuJ6BW0nn6o4SwHBpgBLxz2mi7FfPYYwSbHGt
   bdmdgtZ+A05KLRYmN7VgwMt7z5nTRKm1ZLzCINCjs0HYMAZIlgPiQd9Ni
   O43yqyBOsbnKgY9dL6W909r+GQMw87PXCyTYOTGzAQBeTo8+hC/YBqsU5
   rL2sJF1z1yUSYxRTp0CdtS2rgVrYss6/OOaHR/ndt7RliWwGz6ZuHWdUX
   in1k0cTFej3L4VN+MKCj04+WhOmbQ3sqV/C5+D0TSafdP7MWH8DTPFczz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308795075"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="308795075"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 14:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="805714736"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="805714736"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 21 Oct 2022 14:37:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 14:37:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 14:37:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 14:37:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 14:37:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNe2aKhsr1mz4Lz7men7MuZeEdNxf5wSFzGvKPEVIkXuWW8ROZvTWxRxQFEs0Owi8qFgPaYX/O3Mjv5C8Agenao1/Eyk3F98MvdJQu9KOLgFL2KKBA1tgHagk2NZ49BpIO/NXHELwORO4YPtH+UCW9Os8ieIhkHmaFTMAxCdyziC7fq+0hX8fQ7vYs2KLRqS6MDRz28Y7KOYg8AUquVnNx3SfQlqxKApd2Qd1I5pfIb2L4CHTB3xyMSyDaab9jkrB+6WaDym2ILoEP3iIZ5PReY7oXbk0zpN1ksUpCEiGpMLqV9w1Z11G/isJtkztTxe9NIok5gTNDkTqA7/4TrFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bWQd+0XNCzChNVMdMy93pJWWKPq9bMgt7XfQN8Si+M=;
 b=cmmWtpfZv7IzJpXX76U8oAoin2T6sfzK1Ip8vMAcW7ETNNHa38FU242igAi+R4+qR+mbDK3iIcPAaf580M6XbJa4CNlkSA8JLz2k2XHbcLfeLJkmyh7MpzDXjKzxXCWEQxjxDNgbkUDsjM4j+PuFLzzKpWtxHAB90QV3F5yAm6XZk6/3N/EqoF6mypdJ9R5cXm/Cxy7yt4ZvWmktqcMDOoSycUp0gr1iS0H9YILfQo3mrB2sZmUhsmLq3NSu4fo13IKqzrYQEWawziUN2OpU2DVfj9izfiNeYdqrwXe2aSsZt46GZN1gav0sJI4+SsaOHKWYDwps9AJu6LYQpkwo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3978.namprd11.prod.outlook.com (2603:10b6:5:19a::14)
 by SJ0PR11MB4894.namprd11.prod.outlook.com (2603:10b6:a03:2d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 21:37:36 +0000
Received: from DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::1b68:f941:6705:2288]) by DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::1b68:f941:6705:2288%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 21:37:36 +0000
From:   "Pulavarty, Badari" <badari.pulavarty@intel.com>
To:     "david@fromorbit.com" <david@fromorbit.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "huangzhaoyang@gmail.com" <huangzhaoyang@gmail.com>,
        "ke.wang@unisoc.com" <ke.wang@unisoc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "inux-kernel@vger.kernel.org" <inux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "zhaoyang.huang@unisoc.com" <zhaoyang.huang@unisoc.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Thread-Topic: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Thread-Index: Adjlknw+eMTrXWQwRD6MNs7boLZqkQ==
Date:   Fri, 21 Oct 2022 21:37:36 +0000
Message-ID: <DM6PR11MB3978E31FE5149BA89D371E079C2D9@DM6PR11MB3978.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3978:EE_|SJ0PR11MB4894:EE_
x-ms-office365-filtering-correlation-id: 5acd673b-6739-4cb5-ec3c-08dab3ac7878
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PcPCkW4qhb1/bl/0pGGa80O+UHH/ToNzQIC3N+MEI0Ph9yaHnEnDLQzSo8v/EN2CUkYwP3DwKer5EIl3E0U2FAgquAMUKjDzGwVk/zo3XxgiUA2HjKCTS/S9MzbXWyx7CQzaABkhJ4TWFWSAbnMsvCAw76q00+1gOqRuNL/HUNaOpMqnUYVkt2r3bLYezbrCm8NRYwAiHVzIRxgTgJyEMvmlMwlln8+88jJRdHutOb29N74IC2l68fpP1MEC8O06gKA8HakWSrhCq7LlIL/dwsT3FreDzolfnGcM7+6pgfnvTez50A5fho4YUXt+VPPBijtdVnOZkcgrnBHf5/NAO9yroyyjvrLIOxug5tvpy8NyFvCqxrFLQA/IPctzReW1r88QKAdTOfv3KWUYdoLJ66/JyU/qh2JrZRNElSzcC/Ig5v7Sk4faWm8JoSgACjtsJOt5aywMqumtGy2MeQ2m5GseUe2fu9YSghsYIf+O+WzUsBt7A2ITuvzK8tVVlOExeQ038+ufY2WvoQKb7JwgrESK4XmVOcltQjjewwiqiDjPKa5NzlVPhNd49NPcwIFhnMzgrTxTuvr7dNCr8jfOp1G8OdeLXr8z39O5t8aFvgy/jt0SRFBcyX4WCf9ESX0e2zJA4oV+dnN0tJ4ZZLoFUbSujWc3tntrqfClKLg2wNwKA6swZEGQoD0lMy1q9zMA2G0+T0XfJYieEF6YVdPCsiukj1vNRExv6fhMkB1WJMw38csbtvdfPs128rWvY9qHRUvhtkWVhcr77Nx3+8JgbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(8676002)(54906003)(8936002)(26005)(4326008)(66946007)(64756008)(66476007)(66446008)(66556008)(86362001)(6506007)(41300700001)(9686003)(5660300002)(7416002)(83380400001)(316002)(55016003)(7696005)(52536014)(38100700002)(6916009)(76116006)(107886003)(82960400001)(38070700005)(66899015)(186003)(2906002)(71200400001)(33656002)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JN3L58aDI3rygikjnD+jdFyusN6qo/CRrBkLSMmElbE4Qnklk1sErrbl5LSY?=
 =?us-ascii?Q?xPo/9fkSTGyl2OW2y7CuaorzwKdmMH8VONCx6Gbm7Tv69IMxBHMA2CZfcVgC?=
 =?us-ascii?Q?L5VzvB9DQaAaLwGgBCYJwwXQPDaLjvM/5pLlpETSxuzdgaxdsCLUx51osY6L?=
 =?us-ascii?Q?IckbtygpjeJgkJ8kGj2AxOjxBF2cms4eaS3ncl9FOi48yCgWN9viyx7aEHa0?=
 =?us-ascii?Q?weEL0j/CsgtRufW1sB0KHvacxov2PPGJuW5YdbuGVDhoxkR9FJy7ho5rbpHn?=
 =?us-ascii?Q?DvBbgywuOr5mYGvPBDSv1LbGnrgLpTUYf6XV5Iw3a/YtPQ4MSIad3SrZGFgt?=
 =?us-ascii?Q?V/0pw9RlSrpf9vkpBTGByWtulMoJPdQXgYmC73twcnUWXo5m6YYlqbBaJEI+?=
 =?us-ascii?Q?gCxZXx8l/hBSaWXyLHZp7udiEEGUNd3rNaC3Wm9mUd5by410lF5f/Q1OzuZR?=
 =?us-ascii?Q?MZsciZqV56G/xg4iAZCHb/0aa2+OSxrqZnVjWfSuJVREzW7on12H8Z+oNNgz?=
 =?us-ascii?Q?pEzr4dRzFBzC/hFHShDyPIO8pRFrtQ4/UwgKElrgsW73478WKyLqrWXyHTSD?=
 =?us-ascii?Q?7TvQRoUuebaHIr2U1Imk10pcgPSv7y/Z1C8dGUZNDlSJ7Fv/7XyJHasHQVJa?=
 =?us-ascii?Q?RpXU1AAL4Hq+AYQ9PCn6Il+w1Wy9No3SMldlPDYCydsp+FMgI4/WnlMij+FM?=
 =?us-ascii?Q?yR0/a+oa0sr+o6DfmzPJIH13ThYasDdotZstDhfdu6v0qrPXybFHi37XFiOi?=
 =?us-ascii?Q?MILjx6OKfYdG08ypVuiQZ4n4idysKcp/JOIhg3a6L/9E21mXVZYpA0A+x91U?=
 =?us-ascii?Q?9TizNLxHCgcGGpKeZGz1eDCoFyz7KVOsosQHnI8a+5VRv4xQt9u9YyNAtva5?=
 =?us-ascii?Q?ohotCul8Gz2T1vpBAk/MuJz1UQrV/mCe0WP+Y3S+d9uFW63nGSj3eUPQeG73?=
 =?us-ascii?Q?h5F4rY1xQ7z//JczKXL+MRdbJTROb381gTL/5WLRZ3h7r7OChvahZMGGXreL?=
 =?us-ascii?Q?ia8ZdHx7I+72xxRrf/+Yk23R5+bhROgBxnqumcfBymyRHM2EP/qgpCYmZbar?=
 =?us-ascii?Q?EEMyNO0IpK5Ts9VTge1kfIQiaoJv3zJKQWdEQD66e3UnHKGyH19jEqPXGytb?=
 =?us-ascii?Q?qP6lkfayRS1RtWONxIlFLdEWgCXzWumAz+3qU0Ey5BGF818sSOiHYMqSSmBQ?=
 =?us-ascii?Q?4ZVths0UaVSpd3vUB/WPbpHBMrh6wgSOyo1ZztJ5QkDAYfRlSG7wQQql/DMU?=
 =?us-ascii?Q?lzITvEVhijIBFfp6K3mAEL8dnvt42+BmX0QzUjVyey3tUAvhadwmbSOJMC8i?=
 =?us-ascii?Q?tN3hNkeB9UzE3tP//zaZuxhprGUymJ/kWMyyY1gqqjwNwJBVLo5f+wLm6tm1?=
 =?us-ascii?Q?CaINw491883Lyr7FHca/Lz9gjlF2c+MdNltV90ma5MEj9gUCeAaJPx0a87KG?=
 =?us-ascii?Q?xkfufJeGjAS3nBJov7UGt1nKkUES+RXYnLsCFOplTMVke9fjWjFZRFD5Xhqq?=
 =?us-ascii?Q?5j29/E9tJCYwBRNG3pmqjXrE/Q32SoMzFGbrsIXLqqQuV1nxjI+ob7sr9LqY?=
 =?us-ascii?Q?0l2yKn67fkyGPPDrz2sn6x4Fihm0O1Z7VzPaIpcN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acd673b-6739-4cb5-ec3c-08dab3ac7878
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 21:37:36.2815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QvWmxX52EBmJLzjTjp2Hn46RU2mIVDEw2h6QY2cpryNJlIJRAtoY+FjjqlXrC4KfZi8QmkDDxFMStk9kYHDySt/fzsjSPZWZ657W3ftyWF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4894
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

I have been tracking similar issue(s) with soft lockup or panics on my syst=
em consistently with my workload.
Tried multiple kernel versions. Issue seem to happen consistently on 6.1-rc=
1 (while it seem to happen on 5.17, 5.19, 6.0.X)

PANIC: "Kernel panic - not syncing: softlockup: hung tasks"

    RIP: 0000000000000001  RSP: ff3d8e7f0d9978ea  RFLAGS: ff3d8e7f0d9978e8
    RAX: 0000000000000000  RBX: 0000000000000000  RCX: 0000000000000000
    RDX: 000000006b9c66f1  RSI: ff506ca15ff33c20  RDI: 0000000000000000
    RBP: ffffffff84bc64cc   R8: ff3d8e412cabdff0   R9: ffffffff84c00e8b
    R10: ff506ca15ff33b69  R11: 0000000000000000  R12: ff506ca15ff33b58
    R13: ffffffff84bc79a3  R14: ff506ca15ff33b38  R15: 0000000000000000
    ORIG_RAX: ff506ca15ff33a80  CS: ff506ca15ff33c78  SS: 0000
#9 [ff506ca15ff33c18] xas_load at ffffffff84b49a7f
#10 [ff506ca15ff33c28] __filemap_get_folio at ffffffff840985da
#11 [ff506ca15ff33ce8] swap_cache_get_folio at ffffffff841119db
#12 [ff506ca15ff33d18] do_swap_page at ffffffff840dbd21
#13 [ff506ca15ff33db8] __handle_mm_fault at ffffffff840ddee3
#14 [ff506ca15ff33e88] handle_mm_fault at ffffffff840de55d
#15 [ff506ca15ff33ec8] do_user_addr_fault at ffffffff83e93247
#16 [ff506ca15ff33f20] exc_page_fault at ffffffff84bc711d
#17 [ff506ca15ff33f50] asm_exc_page_fault at ffffffff84c00b77

Tried various patches proposed on this thread chain.. but no luck so far.

Looks like its stuck in following loop forever causing softlockup/panic:

 if (!folio_try_get_rcu(folio))=20
                goto repeat;

Looking at the crash dump, mapping->host became NULL. Not sure what exactly=
 is happening.
Welcome any ideas to track it down further.

struct address_space {
  host =3D 0x0,
  i_pages =3D {
    xa_lock =3D {
      {
        rlock =3D {
          raw_lock =3D {
            {
              val =3D {
                counter =3D 0
              },
              {
                locked =3D 0 '\000',
                pending =3D 0 '\000'
              },
              {
                locked_pending =3D 0,
                tail =3D 0
              }
            }
          }
        }
      }
    },
    xa_flags =3D 1,
    xa_head =3D 0xff3d8e7f9ca41daa
  },
  invalidate_lock =3D {
    count =3D {
      counter =3D 0
    },
    owner =3D {
      counter =3D 0
    },
    osq =3D {
      tail =3D {
        counter =3D 0
      }
    },
    wait_lock =3D {
      raw_lock =3D {
        {
          val =3D {
            counter =3D 0
          },
          {
            locked =3D 0 '\000',
            pending =3D 0 '\000'
          },
          {
            locked_pending =3D 0,
            tail =3D 0
          }
        }
      }
    },
    wait_list =3D {
      next =3D 0x0,
      prev =3D 0x0
    }
  },
  gfp_mask =3D 0,
  i_mmap_writable =3D {
    counter =3D 0
  },
  i_mmap =3D {
    rb_root =3D {
      rb_node =3D 0x0
    },
    rb_leftmost =3D 0x0
  },
  i_mmap_rwsem =3D {
    count =3D {
      counter =3D 0
    },
    owner =3D {
      counter =3D 0
    },
    osq =3D {
      tail =3D {
        counter =3D 0
      }
    },
    wait_lock =3D {
      raw_lock =3D {
        {
          val =3D {
            counter =3D 0
          },
          {
            locked =3D 0 '\000',
            pending =3D 0 '\000'
          },
          {
            locked_pending =3D 0,
            tail =3D 0
          }
        }
      }
    },
    wait_list =3D {
      next =3D 0x0,
      prev =3D 0x0
    }
  },
  nrpages =3D 1897,
  writeback_index =3D 0,
  a_ops =3D 0xffffffff85044560,
  flags =3D 32,
  wb_err =3D 0,
  private_lock =3D {
    {
      rlock =3D {
        raw_lock =3D {
          {
            val =3D {
              counter =3D 0
            },
            {
              locked =3D 0 '\000',
              pending =3D 0 '\000'
            },
            {
              locked_pending =3D 0,
              tail =3D 0
            }
          }
        }
      }
    }
  },
  private_list =3D {
    next =3D 0x0,
    prev =3D 0x0
  },
  private_data =3D 0x0
}



Thanks,
Badari
