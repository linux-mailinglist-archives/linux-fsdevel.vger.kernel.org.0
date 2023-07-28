Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250C67666A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 10:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbjG1IN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 04:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjG1INi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:13:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0861E3A94;
        Fri, 28 Jul 2023 01:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu7do9vqFCgFsADyZ82hNoY/UZLzKuhqMcOnUosc7CU1gRARx52ZsmX/k3jQqqfWApVRnBmUWRhAjuU7NmXABoUauEcu+4BsFWL+iQvWctsSSd3J+OEl1nuojXV5LqlwQAV4O6Aa5FX6RS4QMHq9VxdUVQf3CIB3Lf+dyRKu2d6M6EqS2PnnmZOCYOXwHbqBewL1o/bOMaDqYjze38jxmFhs/Iv+br8SfT+8RW8ik5NSR8vaP81ZQYcdY76GopywsKtifA+tCByL5Om2pzeazLJ3uYUIjt8/7ob+IWLXdba180/f4usweAh8S07h9TWD5tHXBCqcmjq5lBKUTlV0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGPNEOQFiqYcBK63/Om9x23uvQtVmgPahFvNarchGnw=;
 b=bxOPErCsni0aI6FEntZiPQijAIZDy0MW/IxPv639d8y+dZggkTNWOyuFAO/9SE+UgdXasAOUI3wVhzoH+CfaRJmbUIFqJoyEp9Ec5EP+Ir4UV9u4lZPJYEk9+IPq0p73BQdCtzT9xPvZQzKBaCZlGR3snCZTKSywAEhwAMI82788Emd6bxTcZGrPNH2SHdPb+Dy204vWYszNsqa4acgNtWNqodXyDEw0y7myqVcOxLuUrUTT8tRFt3FWyIgK8HDGppCS6jE0eN7Yc4E+jmEmxhvNTLrtTDOkbhwL/D9jHujspqJpRHY4R5d2byBVhKMu4+i1d28V1eeoN8H1OIizYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGPNEOQFiqYcBK63/Om9x23uvQtVmgPahFvNarchGnw=;
 b=m3prTWSXX6KZUhayrV91IRjMJI7ZwF62Kyc+RHKQ5wKJ5j5qAOm8WKXmDTLOzJZexS3MUHCg9Gn6vzAl1zOiXhoEipR2XxPt79A2JuBf25BGhqZ1DaFob4yfuccZFIJJgpycnIR7kUl05XAEhKT1pLB12AmPPln4yziKR08YR+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5269.namprd13.prod.outlook.com (2603:10b6:a03:3e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 08:13:25 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:13:24 +0000
Date:   Fri, 28 Jul 2023 10:13:14 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v3 04/49] mm: shrinker: remove redundant shrinker_rwsem
 in debugfs operations
Message-ID: <ZMN4mjsF1QEsvW7D@corigine.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-5-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727080502.77895-5-zhengqi.arch@bytedance.com>
X-ClientProxiedBy: AM0PR02CA0114.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: 8611e466-4b59-4307-f46d-08db8f4283c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwW465vo9hI5eC/8Ntm80OiPZIBHfs3VML+30ACZ6q1gKIiw07bi63fgQFFRLxhjeMOvYXvKDQCbhdJXvkJtuvlV+CXofrjYF/nUT4dPDX7q3opgHQdml0n1/4JWskU89OGJAciXmkpGNxgq9ry3pQOnhUiBe/rX017qs0avdKvOdhPtlbR+VQVKZn19geR1qa1unKg72RhRR53/MXIMsfQLudax4C3TSjl+Giz2dgx40XXbX34DzfbwIhH5bpBtGAGLaj3zSQAl3qvuVXHTkg909IcoX6oZGllYm2+Eps+5dhGhNgPCU1/7AU4O5pm4wOrjGhtYfZoZ9N02ekDRjKTQ4lquadIeum0uy/WYwMrctBR3EpkOJHSBHPG5+OYlhSGKYRuhxcaOuJyq9NPyXaRtIwoJbm2SQ2E3gbw5UzfYNh4+Zsdlyyf2fqz/nfuTulgnbDZUN06bw3dCKQlgorH/+ohWbaa1SQLbJzCxvKZOx/MJCh1pBm/F2VBIa/so2tKi49EA+ktn349EbCy+bMhrGONwPCzwf2MNJSruQNMUKPHUtE6Ber7adMWlIhvkRQnideoRjxmflS1kiPiAMuBzpM3AyXXbMb1u0RgXupI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(136003)(376002)(346002)(366004)(451199021)(316002)(6486002)(6666004)(6512007)(38100700002)(66946007)(66476007)(66556008)(4326008)(6916009)(478600001)(83380400001)(44832011)(2616005)(36756003)(2906002)(86362001)(41300700001)(6506007)(186003)(7416002)(7406005)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EwJcBo/2mvzDAcZlwWvTX9INa/Cd4/lFcnamw+5KB2J69OYpKA3aGp5Wd/XF?=
 =?us-ascii?Q?Vjt1Q6FMtfkPT96kdcb4hxokRaLTkBreJ1T36jkKBbExivpNKSZ6veIvC/M4?=
 =?us-ascii?Q?jrCBhciqYx3+6CIDSXOzrvyFcFGYL2Yoe1VQGDJ7NdDD5l0XwHG+93LniBR0?=
 =?us-ascii?Q?AC3/KSBGGJTCJ06zamH3IV6dDULUlTJhzm/pIZUJ/EWtK7yxw+go6gb+7bsb?=
 =?us-ascii?Q?GNmIfq+OCxbfIvLSus5tHnhiHP5OesDtsNHLDznFWUW/G/Lmo/+J1OFJzmoH?=
 =?us-ascii?Q?RITysfiVBMj55kz7cS+ZPLvGIfm8kdkhOghNhMN3NBBLtXwtGwJo5omwrNVG?=
 =?us-ascii?Q?J1vTaUl7LcWFEq2X1SOaK8K4/6Ia3JWLxWKLRxy3Ww4uBVp7+2i/SZa9mFbj?=
 =?us-ascii?Q?frtZCGrY28gP1W0cOaS0pH73V5HmSCYk5cbij51ERGBgOpga0ADx0XHxbFwQ?=
 =?us-ascii?Q?O5taUvqZVD+YUBO09GBwkxw/rXt9bZ3p+tl0GkMzDw3rMPNo5Iiqs8Q7YLtl?=
 =?us-ascii?Q?QnIGVeXrT9dOvCPEFdcCjIdtTYbOTjdDHfbAbXIwEN2LEHFDx51xljpLnzoj?=
 =?us-ascii?Q?q6JlISd8nfmBNuAE82FX2Lfg9cjoTaEPWWoVPZG72vP0TPQGCo5rg+N5xg5+?=
 =?us-ascii?Q?RA9dMJEpTUcVArKtlxNThUjNr/lXLQD2djxQG4SygkFdNSbOIg+Py5fn4KMQ?=
 =?us-ascii?Q?VM6sDlWNOXcbgtJIHGGZNj7fiUlUPxTpownfc1c4LE42xLPnRHtGXEP9gqSA?=
 =?us-ascii?Q?snUmINmb3Px4hk0VdGXyakeqY6tNY5w5AGS+MUD7tSY9rFxMbnhmArg+UUZE?=
 =?us-ascii?Q?i73ij7qu7+jTmwf34+LrI95qmZ0ttNUbtvojB+anPSnSbsSmKyG6GOyDgdDj?=
 =?us-ascii?Q?1Q8qS+/Pk+qDjwjSV6oDR5KDVg31OLrvNp/zYuvlMlX0IhekWbiJFuhZcDzF?=
 =?us-ascii?Q?AQLPFRIatsy4f+ShA4r06BfxUfqS9AM3xlDQDA/TuaCkS65hHcKnjG7ssGxV?=
 =?us-ascii?Q?6wo/p/ORe67hNfAjMWhnJoVU5KB1cJ8ra6ei3E+v+SkG6SmMGtAv/0oPpPuU?=
 =?us-ascii?Q?fk42VugnI0lugCDN1EQawQHpI+ocrjKTtJgfvf65Gj0bxKANcxVQOqbjWLID?=
 =?us-ascii?Q?8oXHR6mTmC6ENdB5NHmG42BWQJwcowGxu+i9mU8n3S1/1JXFgKAEOfbrQd/5?=
 =?us-ascii?Q?Cs8GeKBlj4ogqJ9DEvux/7uYG9mSmkqZBCtfXbYeCmm8POr37MhzLWkvTMRO?=
 =?us-ascii?Q?TNw+7pHndTN8XIIottGRIXCDjsLjJkNK37QoW2iOVxgkXOaCDs4v/ZPvu2BS?=
 =?us-ascii?Q?yItjrzpQ7Wv/V/T0mShaQr35yWensUSLg8kwArBLTM+1TpeUjQvlRTRa2QEM?=
 =?us-ascii?Q?eBhHGQssV3+tngbS/tmYBR8K+ByZIKYtpZzqEUrHnOGBWuMmBorzNjocuLAI?=
 =?us-ascii?Q?0pmuEP2b4mk3PLcri7AeHoHgZmpbghkq4M/UOwzgrfPl8rOdOFcanX9cAkZ6?=
 =?us-ascii?Q?9QPpEusH9TeQH4ecp7Cjadc8dwuN5sJzzuVBs840pTrx8rCTXZtCWFBrdxH1?=
 =?us-ascii?Q?GQ8aV1bM3szxVEZWi1L9tiLEBSSbrR18uuwppQLJFRySYRV8eMAQc/EPvB84?=
 =?us-ascii?Q?YOmbXUzPIyQOL7toNCW5V83Ij8+QcxN+t1bzFJsRVsd7LA7EUFd9DTAbDPkv?=
 =?us-ascii?Q?1A2tGA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8611e466-4b59-4307-f46d-08db8f4283c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 08:13:24.7088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZO18g4iU6cCBfbXbdk05XK2h3U98gv1o0RvG8C19b61bZGM6zcodErQeQen1aIioiwU32nm1ls4To/v/MA7i5mi21rgU93wTSzMKCF+aMJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5269
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 04:04:17PM +0800, Qi Zheng wrote:
> The debugfs_remove_recursive() will wait for debugfs_file_put() to return,
> so the shrinker will not be freed when doing debugfs operations (such as
> shrinker_debugfs_count_show() and shrinker_debugfs_scan_write()), so there
> is no need to hold shrinker_rwsem during debugfs operations.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/shrinker_debug.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> index 3ab53fad8876..f1becfd45853 100644
> --- a/mm/shrinker_debug.c
> +++ b/mm/shrinker_debug.c
> @@ -55,11 +55,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
>  	if (!count_per_node)
>  		return -ENOMEM;
>  
> -	ret = down_read_killable(&shrinker_rwsem);
> -	if (ret) {
> -		kfree(count_per_node);
> -		return ret;
> -	}
>  	rcu_read_lock();

Hi Qi Zheng,

As can be seen in the next hunk, this function returns 'ret'.
However, with this change 'ret' is uninitialised unless
signal_pending() returns non-zero in the while loop below.

This is flagged in a clan-16 W=1 build.

 mm/shrinker_debug.c:87:11: warning: variable 'ret' is used uninitialized whenever 'do' loop exits because its condition is false [-Wsometimes-uninitialized]
         } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 mm/shrinker_debug.c:92:9: note: uninitialized use occurs here
         return ret;
                ^~~
 mm/shrinker_debug.c:87:11: note: remove the condition if it is always true
         } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  1
 mm/shrinker_debug.c:77:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                 if (!memcg_aware) {
                     ^~~~~~~~~~~~
 mm/shrinker_debug.c:92:9: note: uninitialized use occurs here
         return ret;
                ^~~
 mm/shrinker_debug.c:77:3: note: remove the 'if' if its condition is always false
                 if (!memcg_aware) {
                 ^~~~~~~~~~~~~~~~~~~
 mm/shrinker_debug.c:52:9: note: initialize the variable 'ret' to silence this warning
         int ret, nid;
                ^
                 = 0

>  
>  	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
> @@ -92,7 +87,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
>  	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
>  
>  	rcu_read_unlock();
> -	up_read(&shrinker_rwsem);
>  
>  	kfree(count_per_node);
>  	return ret;

...
