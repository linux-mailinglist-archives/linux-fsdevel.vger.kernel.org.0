Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E436D60972E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 01:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJWXMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 19:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJWXMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 19:12:33 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01rlhn2180.outbound.protection.outlook.com [40.95.80.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56DA6C100
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 16:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVTB9aRlTGra88fjgWkjpnROsro1NeHhgIFhrFMqchpfTAKeTUfubSCpppvLaD0Ret28zbfOSXvSBeNN5+XYSiOW6Byr40gWltCz2vyTU5ag1HDDJGy7CLw0LL0o+mvHeDnMYCopPkulra4I9p21FYintIxILZw/0Ln2tUVM+Bg16wclR7wiejiK12yGY5jP3t3Psl9EZcW041Yk+reafof0dHaxVqBkMUQKHqppSYJoT1xv+d5IaK63co2o8EtcxjldU3YesgG+qlyd9XlMIYRL9WuN8OrPKy1Ty5s3YomlhASXFV8MDVzyxZqMzqARMhXas7FBzGjJji/hPcS5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nq4MqPwcsOWaECz0wSV53g2tUCbwHfCMZsI8dJAoqjQ=;
 b=OA/1bofvwfFOa90eSf9kdAAhnp7hCTnj7rkz+G8X3EBH8i7bRqqoN2RP2IT/4NO5nvvKPYQOIyu46BrHIpLCjjJlBdzEWahVjnvSbTdcDmbbBqFhUrecm5jvAHXwONbYkde7eY3SbRqKaIE0MvGGp222L+EX5hI6Lw6IefGVw24f1qZTzwi+G2InmGMFYa3PpQurX8hcrm/rZ3Kge3PP/Rya6tEsgbItvgLkbLSXAGgoOQd569wgn3qJyxR41xp2jdwvE4hCcN2/ZqnteEtt5WUw/9yBwKBp775OssokLuXdagEHKNrM/ky4MCW2PwErW4Oo0Yh83KozsLwIYtMg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 213.105.56.180) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brineleas.onmicrosoft.com; s=selector2-brineleas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq4MqPwcsOWaECz0wSV53g2tUCbwHfCMZsI8dJAoqjQ=;
 b=35AfmOexQXlaPOGY6pfz+OOlr9+i6gB0opZOoKsL7A326DklwP+FWVhYk8P8JSji9lpomdg+BsSZLu99RyCzjQOFJdLIOzbG/InQPbKsgv8GBvD+t0Sfu9GcBFB0Mp+fwo2PKn8NaLAhjpYnurp0i2gBwOcXUa3Ol3WiBPmx/Yc=
Received: from CWLP123CA0181.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19b::9)
 by LO0P123MB5942.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:242::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Sun, 23 Oct
 2022 23:12:29 +0000
Received: from CWLGBR01FT004.eop-gbr01.prod.protection.outlook.com
 (2603:10a6:400:19b:cafe::60) by CWLP123CA0181.outlook.office365.com
 (2603:10a6:400:19b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Sun, 23 Oct 2022 23:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 213.105.56.180) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 213.105.56.180 as permitted sender)
Received: from webmail.brineleas.co.uk (213.105.56.180) by
 CWLGBR01FT004.mail.protection.outlook.com (10.152.40.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Sun, 23 Oct 2022 23:12:29 +0000
Received: from BL-EX01.brineleas.local (172.16.0.40) by
 BL-HBD01.brineleas.local (172.16.0.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.14; Mon, 24 Oct 2022 00:12:19 +0100
Received: from gmail.com (192.3.223.142) by BL-EX01.brineleas.local
 (172.16.0.40) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 Oct
 2022 00:12:17 +0100
Reply-To: <chooleech@gmail.com>
From:   <adaincle@gmail.com>
To:     <linux-fsdevel@vger.kernel.org>
Subject: Partnership
Date:   Sun, 23 Oct 2022 16:12:16 -0700
Message-ID: <20221023161216.58756296853AE27A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL-HBD01.brineleas.local (172.16.0.41) To
 BL-EX01.brineleas.local (172.16.0.40)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLGBR01FT004:EE_|LO0P123MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: a77f1fa3-b89b-40d0-66e7-08dab54c0e8b
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0JvaCtwcUFtZ0FlSElxaW9NTDVHRGw2N0MvT2FhWS9naXlUWUxEWmRCQjhB?=
 =?utf-8?B?UXdqUjlzVXQ1STRQMVp5VTZQU2FrRTJXK2VuM3ZmRGpPWThid2phcVFJV1Az?=
 =?utf-8?B?MER6MjlqWXY2bFU4MVNGZlg2ZjZuciswUjBYNVhmYnRrNU8vY1ZpQlRGTGNx?=
 =?utf-8?B?UDFZQ1pDaUtuMHJLNHJTRjROVjVpQzFCMmVEUTBoNlNJSVBOOFpHT0ZUSml6?=
 =?utf-8?B?cDJMdkd0dHVaSEp3cmpDa0U4RGQvMVdYcmlYdE5GOUR3aG5mR25TbWtqK05h?=
 =?utf-8?B?YzFvcllFRWcrSGRIZTQyaEdJRG9xalNQNUlOU3dUTmNhbHJwVXorMDFaNXdT?=
 =?utf-8?B?a0ZxM3FlcjRqQnhiZlNxSkxZeHFqTUpIaU45dmR2RGU3V1BHYTA4V2taWFgv?=
 =?utf-8?B?SHBjcDZ2NUVkbVFjbE5Lc1JHaDQ1L3Y1VnArbnY1cEM1YUtland4dTBKOEQy?=
 =?utf-8?B?T3l1RUhPbm4wd1RsSDFDMWN2ZWZCa2ZCdHpwM3FtczZkcE9QSk95UUI4c1kx?=
 =?utf-8?B?anNGL2F5OCtHekZqOERiZGZUekVWZEd2UmYrQ3M0a2tlVGFPajhqaGlWMGF2?=
 =?utf-8?B?UUVjSGtndi9vZEVPK2s1MFZJY01NS1RwbXR2M09MQTFYeTlhdmJNOXhPZ2Jw?=
 =?utf-8?B?SSt0U2VMenh5SnFqVFhwRTNseTlvejdrZFNtZzY2cDBZZGFRcW5KemNqMnc5?=
 =?utf-8?B?UTJEc0hDZVBpWmxoMEprUmJNSFRpQzFOV3ZWSU8vOWRZcDZnUktNa3NrYS9u?=
 =?utf-8?B?K2VERGFNa0s3bDlNZk8rU0tua2huV2ZQRHpkM0lGbzRwQVlUaktvYXdLWWRF?=
 =?utf-8?B?c2ZPQ2sxWmZTTzJLL3ZoZ3Z3YTZ5dXUyTE45SksyNDV6Y254eHMxWXNTTXFa?=
 =?utf-8?B?V2VNZlZtajIySkVteDVuNy9kWWJOcG80NUVYU1NkUzdmZ3FkdS9ZWGwyVGZl?=
 =?utf-8?B?MWhDdU9wZlNZMjRjb25CT3lNRTZaTjVMUXBOa29Rck0rWWNVUGU4UHBkR0pY?=
 =?utf-8?B?STBwV3BEQ1VXMngwUUtQeDdlY1JnQkU0THJDb0JucDBUMXJxUEVOclVETzhO?=
 =?utf-8?B?S0NDbkJUYzVLOFN0ekprTk9IRnBMMEloM25YbmpHdTE3eUp1OWJJcXNBMjVs?=
 =?utf-8?B?WDBqVEVCVXhNMlBlWVlUOGwrRmhmKzErcnQrNTVWMkozUlZTSjhaUmlHRjRS?=
 =?utf-8?B?VHdWdWtEYVRmV0lUTGpHUjRnem5CQzJLZmVEVDNiNkFkZzdWSWtBQmo3M0Rx?=
 =?utf-8?B?blA4ei93V2tXT1dITlJHMWhIaVl2WTFCTkZybTMyV2hHWk1aRUs4R1hzRzFw?=
 =?utf-8?B?OUc4TG5uOStKTUVhdkJlVDRyUm1icTdBNEp1aWY3KzNPaUdMTTFoV3hXSDlq?=
 =?utf-8?B?TXZmamc1WE40bzhZSzltc2ZONDdTU1lQRE5nMlc3azBOSlhVTVp0OWtvZWNU?=
 =?utf-8?B?V2FCMWFlNm1jL1BMMHpVc20vcUw0eTdnKzA0dnNIbE5WOGZDMnNodSsrckl3?=
 =?utf-8?B?TlpVNlIxRWRSd1RFcmNjNzV0STFXcVZCdm5PUVVMM3JUZU92YXkvSnc3cW5I?=
 =?utf-8?B?WlNyTzZLZmFsbkxtWW80UXRpaFBjL2FkT1JaZkE2dmpMemhNQ2kxeENtdkV4?=
 =?utf-8?B?ZWI4ekJ4Vy9rbWoyYzRXTHMvMWVlMEE9PQ==?=
X-Forefront-Antispam-Report: CIP:213.105.56.180;CTRY:GB;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:webmail.brineleas.co.uk;PTR:180.56-105-213.static.virginmediabusiness.co.uk;CAT:OSPM;SFS:(13230022)(396003)(136003)(39860400002)(376002)(346002)(451199015)(46966006)(40470700004)(498600001)(55446002)(86362001)(83380400001)(35950700001)(76482006)(786003)(55016003)(70586007)(8676002)(54836003)(7696005)(2860700004)(41300700001)(26005)(103936005)(5660300002)(6916009)(70206006)(316002)(8936002)(36756003)(73392003)(336012)(2876002)(1076003)(82310400005)(47076005)(7116003)(4744005)(40460700003)(2616005)(956004)(2906002)(33656002)(82202003)(3480700007)(40480700001)(82740400003)(356005)(41320700001)(135420200001);DIR:OUT;SFP:1023;
X-OriginatorOrg: brineleas.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2022 23:12:29.1724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77f1fa3-b89b-40d0-66e7-08dab54c0e8b
X-MS-Exchange-CrossTenant-Id: 41a4300f-9b0d-411a-a67e-115d58d05597
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=41a4300f-9b0d-411a-a67e-115d58d05597;Ip=[213.105.56.180];Helo=[webmail.brineleas.co.uk]
X-MS-Exchange-CrossTenant-AuthSource: CWLGBR01FT004.eop-gbr01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB5942
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,NML_ADSP_CUSTOM_MED,PDS_HELO_SPF_FAIL,
        RCVD_IN_DNSWL_NONE,SPF_HELO_FAIL,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [40.95.80.180 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        *  0.0 SPF_HELO_FAIL SPF: HELO does not match SPF record (fail)
        *      [SPF failed: Please see http://www.openspf.org/Why?s=helo;id=GBR01-CWL-obe.outbound.protection.outlook.com;ip=40.95.80.180;r=lindbergh.monkeyblade.net]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [adaincle[at]gmail.com]
        *  1.0 FORGED_GMAIL_RCVD 'From' gmail.com does not match 'Received'
        *      headers
        *  0.0 DKIM_ADSP_CUSTOM_MED No valid author signature, adsp_override
        *      is CUSTOM_MED
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.0 PDS_HELO_SPF_FAIL High profile HELO that fails SPF
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.9 NML_ADSP_CUSTOM_MED ADSP custom_med hit, and not from a mailing
        *       list
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am Mr. Lee Chong, Business Relationship Manager at Nanyang
Commercial Bank in Hong Kong, China. I have decided to contact
you regarding the state of the client who managed an investment
under our bank many years ago. If you are interested in
partnership kindly reply to my emails for more information
email: Leechong@asia.com
Respectfully,
Lee Chong

