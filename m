Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BAD773BBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 17:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjHHPy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 11:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHHPwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:52:31 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0621.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833925273;
        Tue,  8 Aug 2023 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhR8nzJDi67Jj8GJ6kQuQ/Dk3+OOFzE7ipPT91oq0YY=;
 b=RgX4rGtKfTMK3etolpqPr4/tFK/CapLJEqPkb2J5n52ZtSvlnig7vFKHqqkcxl7gYR8CyYGBcPoXMAtDOff/3IHRnhwPhi++yGGXSX4hOREFmpO/rV4Lkzl/UQ1E05FZewzrSg+bsaK3fpMBuYFlAmVSMpuP77BqWMLocCoPYTA=
Received: from AS9P194CA0019.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::23)
 by PAVPR08MB8989.eurprd08.prod.outlook.com (2603:10a6:102:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 08:21:29 +0000
Received: from AM7EUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:46d:cafe::60) by AS9P194CA0019.outlook.office365.com
 (2603:10a6:20b:46d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Tue, 8 Aug 2023 08:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT036.mail.protection.outlook.com (100.127.140.93) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.17 via Frontend Transport; Tue, 8 Aug 2023 08:21:28 +0000
Received: ("Tessian outbound f9124736ff4f:v145"); Tue, 08 Aug 2023 08:21:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ff87e41f44a6bd0b
X-CR-MTA-TID: 64aa7808
Received: from ea06c7611131.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E6AD5EB6-09D2-41A7-AF28-C91632198147.1;
        Tue, 08 Aug 2023 08:21:22 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ea06c7611131.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 08 Aug 2023 08:21:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deQQipEitUkSFn+qABM+3WJnKbOU5xLfA4rGltgF06WPzotVuxQb0b6vfbMkE2lbaWmVn0HGAuL6KS+/gIwBENpL4GSJfG0Oy21Y/tPI5sqPunTzp+QblZmSvmF5EjkPzHEDe1LFCoVQoSV5DqzvaelVFq2z6kXNMM/gGiY91IStpya+IOE4GS2iN3waf1bvo0X2Mga0N27OIofr9YbIX0AoL0lHoy8ZIyVA3Sb3KawEdTJJEqtnKbp+Vj0mXX0GaZgx/1avFfP/f3UYTA4AxazDiysZEWb0FU78wxvqp8xEdld1QVTPoEBN6j/4i7OelpwV5irduEbbYAU833185A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhR8nzJDi67Jj8GJ6kQuQ/Dk3+OOFzE7ipPT91oq0YY=;
 b=VdxkacirVL0JeQf/5A/MwPGoZjXZczXN/eDtyAa4beLBgsg+JNtmuBxDx4Ioih1KhUJQl3qgI2IspDKbFeqxPGVP5ml30q+iC+9CvwTbSf4oRCiHNaYwgE6Kyrf1zO8tS4bR31P+T/Ph0t0FM8HxWhTLKageiezMGXyoIP+78CaYiYTsnm/FVbVP6/PhYcM36EpYzL/OMSu0DGKWAvyC9dMekbkQDWpTGx+Bp2Yieid8fedT615urcJ06YRdOuFYF9OK2LISj95rC7vNzWqoSFgIc9L6lMc/iKuMOxr2pPeTdweC8WKHMbbK7XMzXG6pTKso4IkRWCPKLThMvGhKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhR8nzJDi67Jj8GJ6kQuQ/Dk3+OOFzE7ipPT91oq0YY=;
 b=RgX4rGtKfTMK3etolpqPr4/tFK/CapLJEqPkb2J5n52ZtSvlnig7vFKHqqkcxl7gYR8CyYGBcPoXMAtDOff/3IHRnhwPhi++yGGXSX4hOREFmpO/rV4Lkzl/UQ1E05FZewzrSg+bsaK3fpMBuYFlAmVSMpuP77BqWMLocCoPYTA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB8468.eurprd08.prod.outlook.com (2603:10a6:20b:566::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 08:21:19 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::adb0:61cb:8733:6db2]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::adb0:61cb:8733:6db2%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 08:21:19 +0000
Date:   Tue, 8 Aug 2023 09:21:03 +0100
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Ard Biesheuvel <ardb@kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Message-ID: <ZNH679dDPtvotp5j@arm.com>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
 <ZNDFioFIM34VcsuV@arm.com>
 <3a077ff3-8627-4337-9b4a-6a8828eda0e7@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a077ff3-8627-4337-9b4a-6a8828eda0e7@sirena.org.uk>
X-ClientProxiedBy: LO4P265CA0197.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::13) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS8PR08MB8468:EE_|AM7EUR03FT036:EE_|PAVPR08MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: a0123b49-2837-4b14-675e-08db97e8772f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Ft622fNMGkEQ6+U1Ce0LU6Aq4negHwuHPibsTTSdzyK+Biad/755YGKa6pq5qUSdpsqDafb6SVQuq6m2l8mMxammMVF15MqfMb20Nxehvrbijcx1bvFbWh6OW2HZn7dXVHozhsE3mUV49GJO1p7rSRGs6n7X4Oh2f4XiR/7agqAYyuRGajGpCMCsJTCaXed3m32sy3+gRTxkYZ4XdcIokUZoBL6c4EKdXlxPqK7LbLjCgL4IWsgzUZV+lOaLjhlxITZGXui0Ol+AcPS4mU+VEFwtvA5KLBQgsvDeTEyHCJWv21CG75G8tnlc0vMdlTBmBR9/iwLlGE40Tudyy2UonNpWVIjhnEbDK6esI9cYiWBBfeQrkA1kGjE4MMm0SujeI9qeHLrdGyeKOk9SVaalSF1DGh+JVWcdNDZXR+eCL91C3/CeCcCa2skQ9v30dgN162PgVDR87srpDLNiV+WIkZeOygyGwvRevGp4KUf7uQOGvzg5zLR25zrCDYgRYIhZpaNcvw2oWsxFFt9niZPBNdggshVvnaKYILWXR9ABo/AMsYoXn0IXCMuHccgzHO0xP6SUrClzkpHHrHMVJ6nWAFsHm8e1ZQMpnPL8sYMRDtZUux8pImG1zrbKxKrKCHRnw9IA6Sn+35V6vQxyzJHEpQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(366004)(376002)(186006)(1800799003)(90021799007)(90011799007)(451199021)(2616005)(26005)(6506007)(6512007)(6486002)(6666004)(478600001)(54906003)(38100700002)(36756003)(66476007)(66556008)(66946007)(4326008)(6916009)(316002)(41300700001)(8936002)(8676002)(5660300002)(7416002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8468
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d408608a-4334-4b70-2817-08db97e87015
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VUCtesAYY7l/y2l147ZWR/0xvqoYv3cCYJEdWnKTZKBns6nGG/7mUbKmO8V7rHJFBjRhuf0ZnXrUYw6OXrtMr50FaFbbi2Wf0MMHDkvle1kUWDbpO5FXA5eg5eJrnw5stxi//UaeyLzKkfEn6VyWAkQk38WawIrBl/ZKmiEYCl++RFvPMg5JYSGSSAEQymPfAb/lSgu2QZvWkk6E72tFolPQCz1z2+Iqd3WkhBDgp1YYDth8zttb4Nnzd4WIULVFzmvh+5hl6EyVID9/nmdAQ3bdYZj7YlzlCpkvjOsxPjEU4YCDSup5PV9gxWHib+WSnkRx2QHakoV3uBbYpkKyoM55KaoEdDFG6RxEBEt+zAxifmOKD23LC3uWHA0+y4+gC/fTphAzdC5S899cIsJod2cCvbJ54i1hVHHVkR+Oc+88BJPIEgCCCwepxDitowKNUWfCeex3a0OsI3P1mbpNYWAM0HT6AuqKBIEqjn5zo++70uwQvAoj8PLdKlUZcu2vWkNq/B5gY7bKD9R4uvQIGeAPAR3R9hjhxrx9wRSCyZKD2bpETFNLnDHRW0tcRMu90WWoPgG1ENEpqqXIH8czHR8w7sVuqHZ2y5Py8vww2WiCuavUUY5oAmqPDnQsz8FtNGAldggzQU8L5jCvOkuCuhqmDJoaLJwmAzmED2HGKGpQyq6fN1xGREgfpI6uWLs/PpHubASFTeHM0UL/vDndrPyadywNvi1CTMd7syh/BqvqmEJvEeDfQ+wAOCegapIyhlNCDaF1zCc5eYA1Ih4IgwiisTXEG4r1OJ342mMlR7h+prdu19j4XYuMIK0X1Mo
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(1800799003)(90021799007)(186006)(451199021)(90011799007)(82310400008)(40470700004)(46966006)(36840700001)(81166007)(356005)(478600001)(6512007)(82740400003)(36860700001)(86362001)(6486002)(450100002)(107886003)(26005)(6506007)(70586007)(70206006)(4326008)(54906003)(6666004)(2616005)(316002)(336012)(40460700003)(41300700001)(2906002)(40480700001)(47076005)(36756003)(5660300002)(6862004)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:21:28.9453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0123b49-2837-4b14-675e-08db97e8772f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8989
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 08/07/2023 14:00, Mark Brown wrote:
> On Mon, Aug 07, 2023 at 11:20:58AM +0100, Szabolcs Nagy wrote:
> > The 07/31/2023 14:43, Mark Brown wrote:
> > > +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
> > > +{
> > > +	unsigned long alloc_size;
> > > +	unsigned long __user *cap_ptr;
> > > +	unsigned long cap_val;
> > > +	int ret;
> > > +
> > > +	if (!system_supports_gcs())
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (flags)
> > > +		return -EINVAL;
> > > +
> > > +	if (addr % 16)
> > > +		return -EINVAL;
> 
> > mmap addr must be page aligned (and there is no align req on size).
> 
> > i'd expect similar api here.
> 
> That's not what the manual page or a quick check of the code suggest
> that mmap() does, they say that the kernel just takes it as a hint and

i should have said that i expect MAP_FIXED_NOREPLACE semantics
(since the x86 code seemed to use that) and then the mapped
address must match exactly thus page aligned.

> chooses a nearby page boundary, though I didn't test.  I'm not sure why
> I have that alignment check at all TBH, and to the extent it's needed I
> could just be 8 - this level of code doesn't really care.
> 
> > > +	if (size == 16 || size % 16)
> > > +		return -EINVAL;
> 
> > why %16 and not %8 ?
> 
> I don't think that's needed any more - there was some stuff in an
> earlier version of the code but no longer.

it's kind of important to know the exact logic so the cap token
location can be computed in userspace for arbitrary size.

(this is why i wanted to see the map_shadow_stack man page first
but i was told that comes separately on linux..)
