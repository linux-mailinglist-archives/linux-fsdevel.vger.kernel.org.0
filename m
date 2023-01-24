Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA2679BDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjAXObs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbjAXObm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:31:42 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C349D49012;
        Tue, 24 Jan 2023 06:31:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLNcPSyWSOtia569W3VN2vfIs53EEubKZ/4Qm5wevbjBEGQo5ou6hgNT9BSxk6H+SxP/9h5m62Rp2NxBSWWeuLDcxqckAmJuiNbhssT3XyXx9geO3WCClBhISEoqeFCtj7i16rpa54cY1BQi2nALV6j13Ldsoihs1c1e0ssS5y4sUkU7b6H8yZujg+8veVDSR7zDXaG77FPcdCjH7Q3oJTtRmkG/22GUxhtFbb8REceJjzKUVcuIhd09ROUbvxcB3gawFP8SgqB+yNFPHOGDAgA5fDg76Og/YRQUSRxb22k1gNTek38rr/4HLaDPJQy9pmI/DD2dhgVEyI63XBmJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZAqvHJ5Sqj+gU3vCqsEeiEXMRzRRszLZI1S64zYGjY=;
 b=Jc6AoESCG3epZDfgpYEZKkFYJ7BCzJlCQiEJ2uhSSDq/cbYYnv+T6faygLkWaLiF8fTw4bgv5fw0zl7rbSMF+ELOTNZir1S/5BRjJ0xPe5aElW9UdQaapvROu9xIao6gLOPWBNIwnF+0zrLsv/il3Pj0Ko3etScqvUpMb2VUeMna2w/Y3xWfg5RTt9zu3v2HpzjGvNcbgKcfN8uKQVvuLpLONW6bZ0Hh2bzUnV24ZpnPZ78EnesuI5jkEjehOdnx7jqlwSUIILwX172FNxlnquNLG2ROzv1pjeDZeR2pBpG71Cu3JmjLRF4I+cS8fSBZo9ivkg6z3XP+85QrioNugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZAqvHJ5Sqj+gU3vCqsEeiEXMRzRRszLZI1S64zYGjY=;
 b=Mz56+0CFETkpiQVS9GmwuBofsaSKotyXXMdj34GQSM4OJmkDX2L3XJtlFhd4tu+n6BqYZPVssfLddRDcQbVGqyZ39WsC9qCV+zlACsV6jV33HfTxRBHEeLs8H9AkwTeQujxhvYM/YJtD2XNZhQ5eK1C4xmY8GZBARDAV6joD7vrIEb0KPZezQ6TfdIzXSk7BqGfKommME+RncgsIkPwY5DRD2tHtOjXyW+UEg4+nS31enG/hZo7TDZaPCQxTEjc75eCqB/TP+qphq+ORFWJ6KGgYhn07t5gir2DuUiZXLsBfubcXL5gkwfCoxPkduuSGEc9C/xMbVwXrMs56wShNFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 14:31:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 14:31:36 +0000
Date:   Tue, 24 Jan 2023 10:31:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Howells <dhowells@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
Message-ID: <Y8/rx6PQ4z9Tk8qQ@nvidia.com>
References: <Y8/hhvfDtVcsgQd6@nvidia.com>
 <Y8/ZekMEAfi8VeFl@nvidia.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-11-dhowells@redhat.com>
 <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
 <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
 <852117.1674567983@warthog.procyon.org.uk>
 <852914.1674568628@warthog.procyon.org.uk>
 <859142.1674569510@warthog.procyon.org.uk>
 <864109.1674570473@warthog.procyon.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864109.1674570473@warthog.procyon.org.uk>
X-ClientProxiedBy: BL0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:208:91::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4896:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b52de73-5571-4b3a-2fdd-08dafe17b2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wtmIkjl120ocPEZoau+L8lXi4o9cJSCIuAcceqAj5UO3yj45nR5eYYoyHiZwPC0T+HcI2zkGgX4bvd958dDzDGPR6k4kuKrUcL9iBB2mwTmyeaOFk1wekIZ/TSDd0SqRcXMxI3zvzKZiUWPhoJarQrNk35Wk10JCVuJNxF1kZizITDCKoTVsSN1FEBrf6jY51oyM/QvnR4KuHKLFfq86suCyHXgZ6ViYgwMmv/UyIEjujF3NTnHcSl9wlMPpmLi0jfWl/5jRVCA6jW1Nfalz7k9inXLYtlJ5A/HwyHN8cerhT5Y0PrOtQc1QHDtTU4fsq7kOh/4VWskRXsfhRKSJ9cC6fcH4kzOUvsrY8s8rOIPU0OQHy3xdH1lOLUfXwBAwqyu5wQyv6wMrjrvuQ4u7mbV2FsOaVZWBEaEgBfHzQwswLJa3AAdVgCOGVPbqzZH1PR8R7CJ7jsxLMsAqKfMYQcS3bST15l8pQpD5Xa2e+gaXJ/tSZrGjN/LVOd6FHPjWuwPRp0+I7FGPeLOEu9yzVQ2Qs7NJLUw4WJjy9soNIYXdatKY1fDBnpLet3KV3M6DlcRutMjbz97LI26ydXxcgjL2sW3VWUhuXU3L6zCkh5fCulEICjq+oh0ejXIgzLg/71R43uTcazVeFU9Ha4TeKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(86362001)(5660300002)(38100700002)(7416002)(2906002)(4744005)(41300700001)(8936002)(4326008)(316002)(6916009)(6506007)(186003)(26005)(8676002)(6512007)(66946007)(66556008)(54906003)(2616005)(478600001)(6486002)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b8LisN30B55KOQl1Sb/NLVi6KXcQB2wNTlMbr7GzgtTVpAOxKnsCXLaPugSu?=
 =?us-ascii?Q?HDho96MXnQxHUuHsFz4teMVFIn+M6C5rmmVZfiOmcLCONW0dk3KgJFWEpjmf?=
 =?us-ascii?Q?MGPRz25Dx8wDAKseaejCPKWS+igaadM+mZD+qv7EOWJ0653vnmHVOQ/re9ea?=
 =?us-ascii?Q?IMYV/bHPbG0EJhBhDP2392Uy4xHS4pfI/avXWHYFNjPEusvcWSwqkFUlZvns?=
 =?us-ascii?Q?W9x5ueJyxek4L3yj2kHjeJdilZepdp8eBAPBw+ydj3U2mN6YtX5l9jCkI9BW?=
 =?us-ascii?Q?k1fqPkKXIkDdtAvlwC0d7SNomJg8lCouNlQj2EC2sTUAORZviLtoYExVM7Rs?=
 =?us-ascii?Q?tfiaMCxFXvD9sWuWL8B8SjW6nTjY4it0gmtnjlSf1/jSf/urNFwpHBfyBZOc?=
 =?us-ascii?Q?9FtynwSNRh14YUKqYPRXVFHzSgbYVapjODAcQkuRy3GfL2PFC4SBiaKslpv0?=
 =?us-ascii?Q?3i99pt6RPoCMSTG/9/BvaepvLZUfsM9UwGekcC1wPDwsHfbCNfWbKGrJgKZb?=
 =?us-ascii?Q?aIHe1kzBepfYyW82mg1FYPK3D8LnXLugB6DTc3Rgaxauyi4BVPF1GTaqITTO?=
 =?us-ascii?Q?mBbEPpJHQIeKbW7SJkzT2RBdM5IUeShoDIswxPImLt2j2BkEq8N8JsVvdg4R?=
 =?us-ascii?Q?uM5cOOci4uPYLCrJF9zsXoObEwDPD6PkzBl+2KzBb82eOZQJhtsZvzUaBnmc?=
 =?us-ascii?Q?gjMyGtCbrqpVSGwn+0v5dSYYCUR35JwnsO/WimU8KFBin0I0Wc4zDhy4Rct6?=
 =?us-ascii?Q?r0f6GzN27dBrUHCivW5RnCktMfZhvgXO8QGsue7Nl1ohNP6TLr/7e3z/dyJO?=
 =?us-ascii?Q?nYzDT7K3PRBzpnXX5Kgy6Pa/NuD+tmreWHmelifVAGxNsnNsEP7lmxR2+3J1?=
 =?us-ascii?Q?sp3l98UQ69627pRLBiI8o8Y/VcCfAvxGGSKQG4s0C8aFiAsngKXEgFQSX7zf?=
 =?us-ascii?Q?Is2B4cwhMdA16GJPJr49D2f3u2NKrNLsgIhBuN1lU1cT4WX0g9l6Exrcq9R6?=
 =?us-ascii?Q?MljitJdEs6M0PQKASWf4REmM17tRm0ngnMBAnJJ7hdWkqspJc1tlVm6+kR+5?=
 =?us-ascii?Q?To7/0Fqw2zXRN1CSNfiEmi/gy7Me1eZ6zlIbzgaMP35wWQCtDx4F0/VTkDq+?=
 =?us-ascii?Q?8s49WWiLh2aIZDRWZs6Fk0Wdfl9WULh89OPCC4bxkreZBIb72n1UgV3tsPHn?=
 =?us-ascii?Q?60LzazBI94TaEXhm9KmwYojwQUqY7p2lt3eeTkDbEwLvdFFSorqK5DXjkyyV?=
 =?us-ascii?Q?Cw5GpWsXfIKiAh0v5VejJoo5DYKN3redYOXpY+pdWK5v+dC4luhgYRsgpqz+?=
 =?us-ascii?Q?S5TXyDuLkClXIoq+Fj9DymuJ1cSpLIHKgUy/KB2whRjw9pRojiFrFIz5o3fQ?=
 =?us-ascii?Q?Aeoabj1xbbfRKODYnlQwylmWCXYC+/FEBbT1Ez3MNojZSyRMAZl/yndZO15+?=
 =?us-ascii?Q?+mhFGeenLOwvwIeBfaqfhcqgJWqcoczG2C0xWq2Wp07xmcfyNiTBMT3GT0gN?=
 =?us-ascii?Q?FbhWSMaR7q/KlveEn/PILN44mN7p1ZzP4ViT3mT8Xld/kQUk+REQHSGaXvlS?=
 =?us-ascii?Q?PiXerJyr0jZfJCIJ5oWGG/zBDwIxDTvrZ+d/hLeV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b52de73-5571-4b3a-2fdd-08dafe17b2ea
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 14:31:36.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EG6YHvY4hRp3kHIUdXSh3/UNwCP/KQeF/sEO/jSFXRph8c45AAUhdUVy8T8KmJE7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:27:53PM +0000, David Howells wrote:
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > My point was to change that to take a 'bool unpin' because FOLL_PIN is
> > not to be used outside gup.c
> 
> I need a 3-state wrapper.  But if I can't do it in gup.c, then I'll have to do
> it elsewhere.  As Christoph says, most of the places will only be pinned or
> not-pinned.  The whole point was to avoid generating new constants when
> existing constants would do.

What is the 3rd state?

Jason
