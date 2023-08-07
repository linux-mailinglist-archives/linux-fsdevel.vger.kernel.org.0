Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9AE771DDB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 12:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjHGKVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 06:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjHGKVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:21:43 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F150710F7;
        Mon,  7 Aug 2023 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mrs6y9Ptah9WPIEcrIb0ZeASDoxywYFtpPwtKfqhMWE=;
 b=oQyNepHlSzcZkHsVl1gWTKObuR6WipAgDDDyaUwJjBOR5TvLMEJzz0NHus7CsbcjMobDo62Wi1+X58GzYj/qVIek0EQKSgLSIQxi5D3pS8Gtl997RYuBnTyyNQ/dBPybVU/12SuNTphNaWHyc3/6RB34oJwKGVqb8K4TtEJDAU8=
Received: from DUZPR01CA0207.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::9) by AM0PR08MB5476.eurprd08.prod.outlook.com
 (2603:10a6:208:18d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 10:21:26 +0000
Received: from DBAEUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:4b6:cafe::63) by DUZPR01CA0207.outlook.office365.com
 (2603:10a6:10:4b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Mon, 7 Aug 2023 10:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT064.mail.protection.outlook.com (100.127.143.3) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.15 via Frontend Transport; Mon, 7 Aug 2023 10:21:25 +0000
Received: ("Tessian outbound f9124736ff4f:v145"); Mon, 07 Aug 2023 10:21:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d6abb263343ff9e9
X-CR-MTA-TID: 64aa7808
Received: from 7876b55f53d8.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9065A3D3-B4AC-44BB-8CEB-3887A004694F.1;
        Mon, 07 Aug 2023 10:21:15 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7876b55f53d8.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 07 Aug 2023 10:21:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDVtEsOp0ZspyDEtXDuyt2lDuf5M3rqll2Hidi63YbB2TTEh4Vb/wasdd4uwIuPYy2q//Zf5O2L8DksZmVVpaN3VYLpZ5y54Z6Z4tXVZWReNB3xqmVnj0WVmW5Pw0Ubd5/o8DM+V9k7DFXiucOx9FpiSJTvjakD7vWRpUAMKMwkuaKJXRJjuj6T9OzKHZKy4h47bRrmOaykvGUCcI36hDW7A9QnjAPzzNXvF26QG/J+JI1zoXaWVTnkO7mEaKN/4NX2E5JfewoF94wtTtiIGgm3YYZTtuYCDWTo1+Hb+xYdCGcFKNJYVRJt0ZF6leXny8pNevr0kVY6BWAKXbukVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mrs6y9Ptah9WPIEcrIb0ZeASDoxywYFtpPwtKfqhMWE=;
 b=cMABMlLUSQEgcDRC48dwh12XE/QqL/SgrUWPWlNMDnISJYswVit6whfTZo4umx96pGT1DLzJxydfn9MrgyqmtXjNIm38FSbcQ86VNuxYuLHO2cXumpMRTO9tsbeiRE7DVFiE0AwkpF79HAeLS+vY846I2qltkFbwiX+OK8DMdNsTYw2/VCfjGzOp2I9NuHaYI+kHClPUtqmwqax9dgeFXGXahuBCFtCqvGnlK2kYbZbSWnJmedvXcvRWCXLmUwbXBDs/F3B41JLf1Q58FZoMyJfT8pQTu7pMQPaoSwkIavJOD4Dzht3PMVWC+/F1LyifYl9c3Nd0aKluTzOsZuKphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mrs6y9Ptah9WPIEcrIb0ZeASDoxywYFtpPwtKfqhMWE=;
 b=oQyNepHlSzcZkHsVl1gWTKObuR6WipAgDDDyaUwJjBOR5TvLMEJzz0NHus7CsbcjMobDo62Wi1+X58GzYj/qVIek0EQKSgLSIQxi5D3pS8Gtl997RYuBnTyyNQ/dBPybVU/12SuNTphNaWHyc3/6RB34oJwKGVqb8K4TtEJDAU8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB10151.eurprd08.prod.outlook.com (2603:10a6:20b:628::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 10:21:12 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::adb0:61cb:8733:6db2]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::adb0:61cb:8733:6db2%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 10:21:12 +0000
Date:   Mon, 7 Aug 2023 11:20:58 +0100
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Message-ID: <ZNDFioFIM34VcsuV@arm.com>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
X-ClientProxiedBy: LO6P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::7) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS8PR08MB10151:EE_|DBAEUR03FT064:EE_|AM0PR08MB5476:EE_
X-MS-Office365-Filtering-Correlation-Id: c72431a3-cfbc-4efc-6995-08db97300e62
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CTRobn5o9nqHHhogJ7n8JBCHnbaaCwFAgnJ1NMXylevQ6J4xtiPtYYyAvqQCiRG/rMlJ5OGosHgNx6zVzMwOE46qZ6ysELCvpfVTxVKI1xYrVYjM0IjDYfsk6TgFFehNoHe/t03778ZtffFy70hdIXk24wXL+PjrFtjJ3LowlG4JD/wySKmJEJVAKC98NbAh453Eibky/SExOELBrzoGxTMT+XVxAbd02vXqLgI5+tsYi3uFU0BRQb7ZSPZvdnRI4dtqKL9+o2uuSLJUgRCDAJL0h4+3c+M+7pNhdxAVhRgU9yVxRCFLa2uIMJCHgqeKrxwqfqIS2Mu3zGMjkvOA3K6t91e/JDGg8wMRn+Kv2nf0KnOp6hu/WDAy0d4wASwNbeeGZyQpFEVYjQrLwD0U7heWx8BRW1wYJh4Z9RWpXMhlvskb8YMl6zabT/a8WF7kOSwHpD3T55kjTUbnbogY+Ly3nKfeigmXV8nLWBAeC0I0gBaTk4pbdxXkHfZ4lFfpkdjzK6KRyuGI8pt6altuAOvwyl6w/FHbUmeF8WgNdp+JlfSFwdYFG8kILSugIySaEpx71QCDaSX4CZoZeM3U9KIzZdTbB2XIZT2ceyeX4W0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(1800799003)(186006)(6512007)(26005)(6506007)(36756003)(110136005)(54906003)(38100700002)(5660300002)(7416002)(86362001)(4744005)(4326008)(2906002)(66476007)(66556008)(66946007)(41300700001)(316002)(8936002)(8676002)(6666004)(478600001)(921005)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10151
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fbe038b5-8ae4-4c9f-ce87-08db973005e5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OnYTicc3g4QWAuhipwb+rvZ5MWFXP01n2gRK2Pp0c5XxDTbHCDOdp0FWwXzbdPXHU5zVsCLgv2X7wFit5mYHNGjLH2cRYGjb9YsPg9kBA3ith650XlJJwi/uM1//1wpFJnks7XWXdvBYbQXvK6LSXeT5rsQtV3J3qZBx4yFYdVOK4NcCyq0dmi6VvTCfTDZKIBdJ4jhPLfeUwnDnBztfnIXUu2A/SRR/9MRrvKGwefvRlAjOCAEktd/PW37hPT11oDkU+AewDiseglQTS1ol2lz16/GWa8pAp2sGMxvGXzcyKx3Wvvp7b8FBa4HlBaeYEIkdS6mTDC4/idKt3a2NAirnyJqb1r3O7ntTvTI59pzQr2VYtyuiZbdjgc5mV5OHTSBT+IGmxJTTI7MNrptiA4bFrQ25MBA5l1OalfL9RNzO6yOZhdvq0qi8IiE+Kk3c45dD+plxxuSY3GI3XscDL00QUxvtrpbyZme7SDXE9cwHmlKIYkRG0onEtMgVDgaU2DWzcYeBZN8wcMVjCH+G9a+bbMumEeCS2rkUd8i9NTPlZ4aKIOnVQYTFzi7Z9/kcFLCCpnipBHdGxhOUNQl+RQCB2MyRRn1d9scjluyt4Qtqrlucp4qvt3TyTtROHgaCY8hTWF69JXLH2AacJD9990Dgv25fLMxmxXsyilHhpYmESPvf5CVCa6t+jGT3xTtXnKTJSCXzwHxY/mCkvYuoHzuKcQJRgb9dxkBBj2i8cQM0kvHP/15KdtVjlkTaZ77
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(82310400008)(1800799003)(186006)(46966006)(36840700001)(40470700004)(6512007)(40480700001)(26005)(6506007)(107886003)(40460700003)(36756003)(54906003)(110136005)(5660300002)(86362001)(4744005)(4326008)(2906002)(450100002)(70206006)(70586007)(41300700001)(8936002)(8676002)(316002)(6666004)(921005)(356005)(478600001)(81166007)(82740400003)(2616005)(47076005)(36860700001)(6486002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 10:21:25.7205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72431a3-cfbc-4efc-6995-08db97300e62
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5476
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 07/31/2023 14:43, Mark Brown wrote:
> +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
> +{
> +	unsigned long alloc_size;
> +	unsigned long __user *cap_ptr;
> +	unsigned long cap_val;
> +	int ret;
> +
> +	if (!system_supports_gcs())
> +		return -EOPNOTSUPP;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	if (addr % 16)
> +		return -EINVAL;

mmap addr must be page aligned (and there is no align req on size).

i'd expect similar api here.

> +
> +	if (size == 16 || size % 16)
> +		return -EINVAL;

why %16 and not %8 ?
