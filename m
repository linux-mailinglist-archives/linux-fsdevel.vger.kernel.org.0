Return-Path: <linux-fsdevel+bounces-5676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12FA80EB34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 13:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FB228206F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046985DF3F;
	Tue, 12 Dec 2023 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="6ytu8UIZ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="6ytu8UIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6121C9F;
	Tue, 12 Dec 2023 04:04:05 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=dbRaV/Us/kohTjRafWS0jCA8hxf263NoyuMqNx3oQWEUXJszUIqILPA5C6epyQc2PdYed1mlJjNnxojSQ5NZJhfm5Sln+MoCoweobMGn8NSRGxsxnzPrxOib95LGzO6QA7qkP5jevYkgDkNle17yZ+oHPUmVkTa6MQtN/I98YPPn5pieiavOmWRIWCzby3BfyovWLluj8eNV0F1smu4zISaKWH7C7CQ23E8s6GlOsnPvKEXJLZTT24e2EMYSOXiIjJM6vOOoZ1FNjDlwwN1nF0Tj2ovvaV21Ig5tKQ34x61xw1uJsvnb3/A4YHm03jRYRWVXPQKnN+wC1gE+483iuA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKWzbD6Bn2L3zm5IeJhBhUTnYgDoW5cq3xP62ESTFz0=;
 b=ACwnvqNDgScFBZ0Obyg1wQIfTbpbHLcwWRh5D1JVoaZD+0wzjfe8RV2IT+sdb82uexyyV+Jgs7Htd+B1skErTSZVuSjx3qjeqZihhK7sck5hoLwnuUshyyjImmn2QcbIerer0r+DuHf+nLpYRDhZZyui4zj6h4WeN2SNks2jTumVvx3IptjxrT6iVdywmwIxC+/pIcok9NOXWtLndyL7oUdcUF8t0HT2B4qC+JjdTPjS2mx+cUNydIcnBYpEibGqWtZe0kf4TfopebFEgq7Z/Y9D7+DNuwwpj4pdYbZwkanxH+AkRwaswuS047AlkUQLeu0RN4CbrTmewYhnWu/eSQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKWzbD6Bn2L3zm5IeJhBhUTnYgDoW5cq3xP62ESTFz0=;
 b=6ytu8UIZHTv0MQ7dGSBBG72lVuYKOkmFhWI3iCCotLJ+T/fVLkWl8tOODLsnS9V9mAIP4rXSx+aMomdkuzvwipFSSbliV5wr0TkEm1xoDCghmm7iZrLZjdDdT5t/jTEL+G6ENF3MfHVZsfyIwaAETbZ7d0G82SAzWvB+G11Grog=
Received: from DUZPR01CA0349.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::14) by AM8PR08MB6498.eurprd08.prod.outlook.com
 (2603:10a6:20b:364::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 12:04:02 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::16) by DUZPR01CA0349.outlook.office365.com
 (2603:10a6:10:4b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 12:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 12:04:02 +0000
Received: ("Tessian outbound 385ad2f98d71:v228"); Tue, 12 Dec 2023 12:04:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1c65ca2e2b61e7e8
X-CR-MTA-TID: 64aa7808
Received: from 2c6765903e7f.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 876A3F85-4F1A-4AC8-885A-EBA7D6EA1980.1;
	Tue, 12 Dec 2023 12:03:50 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2c6765903e7f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 12 Dec 2023 12:03:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxLip3L+cTCLR2hSUzpAllj25sYFrkMEYEkmYf3ygy4qMhdT15fq1Bwc80XtPrC+l7Ady9B8nwhxuGCZ2om8O8caxgJOSW/BiI49KkiLGjlxVwukxAyqKyo6P3mkw3d0y9k2yvftfHr5BuVBjVxz/DtLqEqtmbK31YYKchYTpC7WNz4lc10evgalI/plCsN9JIyfx+uLLBVhWslroFapi/eQXpBrcPTbsAEMDIUD05/qxGR2YxfTxYZnDixDPQ9Je9CKXWawpbwtfDiCet8Jjn5Dv1eS/465lkOHNfYoex8X2klduWJzmzu954OsiqH1tb2tTfYh2/J35qJsP3QZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKWzbD6Bn2L3zm5IeJhBhUTnYgDoW5cq3xP62ESTFz0=;
 b=J0rksiLZF5yLD5+9YZHz7/QEmQIg8bzauvWn7/GwUmJtil6kfj9SgwKqItkN578RyxgFTE1sMkVgDzByy8rmrtJ1Qjb76k/L9P0vosDcDYRnhpaaHeNS2Wbjkl65igxW1iBJ0S2lWOal9Et+YVwEvHTOKbTZkekdAvh8wnlhv8NW3q+/gI0xKWJecBeQdrNnDD8TRiv2zKbOG78Rr5YzjMSgn3aSoFJWX7Jjk66jUOLgv6mJHb8w7q4XE6Nb081tgMNZ1dYHVgWkCeAAkMj/VWdDzCyDBhQ041eYBD7J6uZPIOW6LJatza80SQDgVdUz5ZFoXIa2/XVUZudqbS9J8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKWzbD6Bn2L3zm5IeJhBhUTnYgDoW5cq3xP62ESTFz0=;
 b=6ytu8UIZHTv0MQ7dGSBBG72lVuYKOkmFhWI3iCCotLJ+T/fVLkWl8tOODLsnS9V9mAIP4rXSx+aMomdkuzvwipFSSbliV5wr0TkEm1xoDCghmm7iZrLZjdDdT5t/jTEL+G6ENF3MfHVZsfyIwaAETbZ7d0G82SAzWvB+G11Grog=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DU0PR08MB9417.eurprd08.prod.outlook.com (2603:10a6:10:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 12:03:47 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::292d:9c0e:e9f7:deba]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::292d:9c0e:e9f7:deba%6]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 12:03:47 +0000
Date: Tue, 12 Dec 2023 12:03:32 +0000
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com, broonie@kernel.org,
	dave.hansen@linux.intel.com, maz@kernel.org, oliver.upton@linux.dev,
	shuah@kernel.org, will@kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 15/25] arm64: add POE signal support
Message-ID: <ZXhMFBK3khQHo2lX@arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-16-joey.gouly@arm.com>
 <ZXdamak1wDyUdwSG@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXdamak1wDyUdwSG@arm.com>
X-ClientProxiedBy: LO4P123CA0237.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::8) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7179:EE_|DU0PR08MB9417:EE_|DB5PEPF00014B9D:EE_|AM8PR08MB6498:EE_
X-MS-Office365-Filtering-Correlation-Id: 48176aca-5040-41ae-9dcf-08dbfb0a6e75
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 vqTC7MCwQjvg+749Nb+1kyFvUqKcIMQp4ENNJDwgEwAZSTZEByOpjuTLc0Fr4OoNhLR6ICTjLqOgL9AvcGtlUtx7YwIlnf2q7A7kZ4y2QyuBfQ/PAo3HG2i+7pjOjhXs8PE/ssIdScY/N0vYYkjlzWEyGVP2zh+/0gmpdQc8xCluXvUlr6VJ7dUR2CBWV26NZMxkjyUnbXhEPUhEonPNTTAuAeBzmwsyWW1T+oSlGhhS5cUPYUanUOC+1IjsunjE8yTAyluGfbEBuL/7dN9JBZpSTNdBvOcWIuwxB3dfqYpBzOwihXjpgAmZb2vhGmzl8As/dPSKokm679GE4S92TzDT7GBrx5qMUwFilNDCTIfvBVB8vpBBatiBfRCic5T0mCamwwOTxbDquwTfdCcfPZVMOGsJtYaQwuqtN+OJFzsGtLJEM5MbVoeV9NWfrmCODIoThmNbV+gTB2nwyceTqE/YC3Cwz1V79uzhysQsdgYzNMZ9ccToaRdzpzX2vNEPw/k+wqjTOnJxyjcNtKSBJ098IbM5AzodwJht4Prwf5WEkB8PQQ03Z1YxNthAKWCA
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(6512007)(2616005)(6506007)(38100700002)(66946007)(44832011)(4326008)(5660300002)(8936002)(41300700001)(7416002)(8676002)(2906002)(6486002)(6666004)(110136005)(478600001)(316002)(66556008)(6636002)(54906003)(66476007)(36756003)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9417
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	011000a8-fc5d-49b5-4949-08dbfb0a659b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hR87tiAzYKw9oOsRdTfVCTLW4YlHB5nAkRDd9nd1vjC3Iz0Q0LyNT2jILk6ZO6izAfcf5UeN3jWlYM/7SdDWYRC3w8613vcuAkbZnx8Ch8y2JzjNRrjTe0C1ke/flUBh5A8DwC076sc68nu6QkwRfWEjkTIPBbln+FNC0DllciL7tRAKWmWjQSCqnP4nF9wRpFLiNwfG6xw1o7lpryUKFL6ljka6qPX3vS0p/AvUogV1KKmFJfx48daM1ev0JOAnHR5sA0vdkZEuT+phKacCPRA3OzZ03sm+7dFNp7Ia1rl9Qb7wYYyH3BsnX6JmCvnjow5m/JB6I8blwvEwzQH+8+zbhYI/cUHLa4Hj15VAdDluenieORLtNc+IUb/wp05dcZZXSsem0IjvHwgh8pU1ZKrNtEmjhSuSZhE1QN9az1cbb5TV7/tdKX5WRzs1ui73Esn1mSeT7ll+aQoZwAZc4Jgm9M15vVHvUCc8biHJlPpyFrToKkKQF6VNYRDBjLLV3ls/Nyv4RUzg6OgzCxAqpOfsZAmMi1UaK5Aj/xhMmjDq7MaT4KA0WlETceuWBqQCIBB8Gu+0c9tjoWfCmsTiRLnb11wRgNfYgHqMmlbwLuHFXlg3BiybGq6KR/I6cdftQTX3T03iHEyzYOttk6OtoywptgnJvy0kVhWnvhIgoeRrN417+WVn39kELxlrqT26OzpzoKOY7EKISc2PDc0T4Ahc5Ms+EX8JblKcvxlepnbGUj/PbDp/vp4BZQ0qNpg8
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(336012)(107886003)(83380400001)(6506007)(6512007)(2616005)(47076005)(26005)(36860700001)(4326008)(5660300002)(8676002)(44832011)(41300700001)(6486002)(2906002)(6666004)(8936002)(316002)(478600001)(110136005)(70206006)(70586007)(36756003)(86362001)(6636002)(54906003)(450100002)(356005)(81166007)(82740400003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 12:04:02.4191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48176aca-5040-41ae-9dcf-08dbfb0a6e75
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6498

The 12/11/2023 18:53, Catalin Marinas wrote:
> + Szabolcs for libc ack (and keeping the full patch quoted below)
> 
> You should cc Szabolcs when reposting, we need his ack on the UAPI
> changes.
> 
> On Fri, Nov 24, 2023 at 04:35:00PM +0000, Joey Gouly wrote:
> > Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.

this looks good.

Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>

> > 
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > ---
> >  arch/arm64/include/uapi/asm/sigcontext.h |  7 ++++
> >  arch/arm64/kernel/signal.c               | 51 ++++++++++++++++++++++++
> >  2 files changed, 58 insertions(+)
> > 
> > diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
> > index f23c1dc3f002..cef85eeaf541 100644
> > --- a/arch/arm64/include/uapi/asm/sigcontext.h
> > +++ b/arch/arm64/include/uapi/asm/sigcontext.h
> > @@ -98,6 +98,13 @@ struct esr_context {
> >  	__u64 esr;
> >  };
> >  
> > +#define POE_MAGIC	0x504f4530
> > +
> > +struct poe_context {
> > +	struct _aarch64_ctx head;
> > +	__u64 por_el0;
> > +};
> > +
> >  /*
> >   * extra_context: describes extra space in the signal frame for
> >   * additional structures that don't fit in sigcontext.__reserved[].
> > diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> > index 0e8beb3349ea..379f364005bf 100644
> > --- a/arch/arm64/kernel/signal.c
> > +++ b/arch/arm64/kernel/signal.c
> > @@ -62,6 +62,7 @@ struct rt_sigframe_user_layout {
> >  	unsigned long zt_offset;
> >  	unsigned long extra_offset;
> >  	unsigned long end_offset;
> > +	unsigned long poe_offset;
> >  };
> >  
> >  #define BASE_SIGFRAME_SIZE round_up(sizeof(struct rt_sigframe), 16)
> > @@ -182,6 +183,8 @@ struct user_ctxs {
> >  	u32 za_size;
> >  	struct zt_context __user *zt;
> >  	u32 zt_size;
> > +	struct poe_context __user *poe;
> > +	u32 poe_size;
> >  };
> >  
> >  static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
> > @@ -227,6 +230,20 @@ static int restore_fpsimd_context(struct user_ctxs *user)
> >  	return err ? -EFAULT : 0;
> >  }
> >  
> > +static int restore_poe_context(struct user_ctxs *user)
> > +{
> > +	u64 por_el0;
> > +	int err = 0;
> > +
> > +	if (user->poe_size != sizeof(*user->poe))
> > +		return -EINVAL;
> > +
> > +	__get_user_error(por_el0, &(user->poe->por_el0), err);
> > +	if (!err)
> > +		write_sysreg_s(por_el0, SYS_POR_EL0);
> > +
> > +	return err;
> > +}
> >  
> >  #ifdef CONFIG_ARM64_SVE
> >  
> > @@ -590,6 +607,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
> >  	user->tpidr2 = NULL;
> >  	user->za = NULL;
> >  	user->zt = NULL;
> > +	user->poe = NULL;
> >  
> >  	if (!IS_ALIGNED((unsigned long)base, 16))
> >  		goto invalid;
> > @@ -640,6 +658,17 @@ static int parse_user_sigframe(struct user_ctxs *user,
> >  			/* ignore */
> >  			break;
> >  
> > +		case POE_MAGIC:
> > +			if (!system_supports_poe())
> > +				goto invalid;
> > +
> > +			if (user->poe)
> > +				goto invalid;
> > +
> > +			user->poe = (struct poe_context __user *)head;
> > +			user->poe_size = size;
> > +			break;
> > +
> >  		case SVE_MAGIC:
> >  			if (!system_supports_sve() && !system_supports_sme())
> >  				goto invalid;
> > @@ -812,6 +841,9 @@ static int restore_sigframe(struct pt_regs *regs,
> >  	if (err == 0 && system_supports_sme2() && user.zt)
> >  		err = restore_zt_context(&user);
> >  
> > +	if (err == 0 && system_supports_poe() && user.poe)
> > +		err = restore_poe_context(&user);
> > +
> >  	return err;
> >  }
> >  
> > @@ -928,6 +960,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
> >  		}
> >  	}
> >  
> > +	if (system_supports_poe()) {
> > +		err = sigframe_alloc(user, &user->poe_offset,
> > +				     sizeof(struct poe_context));
> > +		if (err)
> > +			return err;
> > +	}
> > +
> >  	return sigframe_alloc_end(user);
> >  }
> >  
> > @@ -968,6 +1007,15 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
> >  		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
> >  	}
> >  
> > +	if (system_supports_poe() && err == 0 && user->poe_offset) {
> > +		struct poe_context __user *poe_ctx =
> > +			apply_user_offset(user, user->poe_offset);
> > +
> > +		__put_user_error(POE_MAGIC, &poe_ctx->head.magic, err);
> > +		__put_user_error(sizeof(*poe_ctx), &poe_ctx->head.size, err);
> > +		__put_user_error(read_sysreg_s(SYS_POR_EL0), &poe_ctx->por_el0, err);
> > +	}
> > +
> >  	/* Scalable Vector Extension state (including streaming), if present */
> >  	if ((system_supports_sve() || system_supports_sme()) &&
> >  	    err == 0 && user->sve_offset) {
> > @@ -1119,6 +1167,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
> >  		sme_smstop();
> >  	}
> >  
> > +	if (system_supports_poe())
> > +		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
> > +
> >  	if (ka->sa.sa_flags & SA_RESTORER)
> >  		sigtramp = ka->sa.sa_restorer;
> >  	else
> > -- 
> > 2.25.1

