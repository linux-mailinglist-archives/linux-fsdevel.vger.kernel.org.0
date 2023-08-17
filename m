Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DE077FB54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353401AbjHQP6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 11:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353402AbjHQP54 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:57:56 -0400
X-Greylist: delayed 243 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 08:57:53 PDT
Received: from mail-edgeF24.fraunhofer.de (mail-edgef24.fraunhofer.de [IPv6:2a03:db80:3004:d210::25:24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF95430E9
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1692287873; x=1723823873;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r5ZCuA5fI4UxP5WNLVSaTs10LxghBDkVmUmhJBwyhNs=;
  b=M+GE1DKSatdfNylkDLQSjUTppMOghJO49jAgoId9Fc4m3dE4VNUjPUWB
   v204PyrMQD9thVsl3n0ZDVBbOC0CvwSbYF/tDV9oSbHjCGUHDbJ8EWbeJ
   haHUxQQoKMpAbWp4QQ6xI1bLnfHZil5QNbvo2izi2CknBqbb3X4gOZJpY
   Z3G1CsKwN/1ZwzXQDyAoi94p7oWNwmTl8A1S42Mo4ajCL/rTYBaPgjk2o
   xo8Ot7LIQlAJLCJhQVexKcQE5MfSfTY27ICt111yaa/LJ+EbZN6+SKYdu
   wQ79e9XfqMRG5VlCkUccOuo4Phox6OeclCBgzreT11GAF3q1FB3Xk6UJQ
   A==;
Authentication-Results: mail-edgeF24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2F9BQA/QN5k/xmnZsBaHgEBCxIMQIQCdoFchFKRLy0Dn?=
 =?us-ascii?q?EyCUQMYPg8BAQEBAQEBAQEHAQE9BwQBAQMEhHUKAoZgJjgTAQIBAwEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEDAQEGAQEBAQEBBgYCgRmFLzkNgnJkgQgBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEXAg0oUQEBAQMjBAsBDQEBNwEPCxgCAiYCAjIlBg0BBQIBAYJ6AYIqA?=
 =?us-ascii?q?zEUBqxyfzOBAYIJAQEGsB8YgSCBHgMGCQGBCy2DW4QmAYl6gk+BPAwDgQaBb?=
 =?us-ascii?q?z6CSxcBAQKBJTkVg0aCZ4lrhUkHMoIri0wqgQgIXoFvPQINVAsLY4EVgSiBH?=
 =?us-ascii?q?wICEScTFAVFcRsDBwOBBBAvBwQyHQcGCRcYFyUGUQctJAkTFUAEgXiBUwqBB?=
 =?us-ascii?q?j8RDhGCTiICBzY4GUuCZgkVDDVQeBAuBBQYgRMESyUfFR43ERIZDQMIex0CE?=
 =?us-ascii?q?SU8AwUDBDYKFQ0LIQVXA0gGTwsDAiEFAwMEMgQOAxkrHUACAQttPTUJCxtGA?=
 =?us-ascii?q?iefHXGCB0YBPC0lKy8lfQluBpYBAYwColgHgjGBXYt+iEqMQAYPBC+EAZMiN?=
 =?us-ascii?q?5IBh2aQRI1glHKFRwIEAgQFAg4IgXqBfzM+gzZSGQ+OIIN0j3t0AgkwAgcBC?=
 =?us-ascii?q?gEBAwmCOYY1gloBAQ?=
IronPort-PHdr: A9a23:RJZf9RGe9EUvx0HNIpPAy51Gf29NhN3EVzX9l7I53usdOq325Y/re
 Vff7K8w0gyBVtDB5vZNm+fa9LrtXWUQ7JrS1RJKfMlCTRYYj8URkQE6RsmDDEzwNvnxaCImW
 s9FUQwt5CSgPExYE9r5fQeXrGe78DgSHRvyL09yIOH0EZTVlMO5y6W5/JiABmcAhG+Te7R3f
 jm/sQiDjdQcg4ZpNvQUxwDSq3RFPsV6l0hvI06emQq52tao8cxG0gF9/sws7dVBVqOoT+Edd
 vl1HD8mOmY66YjQuB/PQBGmylAcX24VwX8qSwLFuU+nD6fPmyvAmtIgwwOzDO76dZcLVWmEz
 pV3bRTzt3cDamUmr0D809BUs58O83fD7xYqz6+TO6TFO+dGJIfhJPo6RFZEcM1schJkOrqxN
 MgBFepQHqFCi9ajvAI3nRG8BBeNKLyx9jkPvXXVgpEbyvYNFSaF5wgAJ8Ig6W/RnMj6MYUWf
 fqN74bKliWSSskVgzfR7Y/0TDB6pv+pW5RTYcvO1BYJCR7At2mui4nrZhO12MojjlDB/89kf
 tyRkGE2pSIoqTz0xJkihLXj290Mk1no1AhE6d06B9iKaUIrNI3sAN5RrSacL4xsXoY4Tnp1v
 Dpv0rQdos3TlEkizZ0mw1vSZ/OKXdLUpBz5XfuXITB2iWgjdL/szxqx8E310uTnTYH0y1dFq
 CNZj8PB/m4AzR3d68WLC7N9806t1CzJ1lX75PtNPEY0kqTWMdgmxLsxnYAUqkPNAmn9n0Ces
 Q==
X-Talos-CUID: 9a23:143M/G0tnLZ4jHncTQeVsrxfO5wUTFfh/nvrGxW7K2Jia+KHS1GtwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3AuGFZHw7C0lWuEZT+xN3sOV6PxoxS/4GyWAMmla5?=
 =?us-ascii?q?bosTcGxx8YHSkpmmOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,180,1684792800"; 
   d="scan'208";a="58410604"
Received: from mail-mtadd25.fraunhofer.de ([192.102.167.25])
  by mail-edgeF24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 17:50:36 +0200
IronPort-SDR: 64de41cb_y8GU7cDunR+TChFNzyRY+DAVrc48PYB/7HzZtPmSGIPfYag
 AwbtvaNUDdHEhdK9+xfFrIbH9nSkBZIho7mSH0A==
X-IPAS-Result: =?us-ascii?q?A0B1CwDBQN5k/3+zYZlaHgEBCxIMQAkcgwtSBz0yWCtZh?=
 =?us-ascii?q?FGDTQEBhS2GPQGBdS0DOAGcE4JRA1YPAQMBAQEBAQcBAT0HBAEBhHwKAoZdA?=
 =?us-ascii?q?iY4EwECAQECAQEBAQMCAwEBAQEBAQMBAQUBAQECAQEGBIEKE4VoDYYFAQEBA?=
 =?us-ascii?q?xIRBAsBDQEBFCMBDwsYAgImAgIyBx4GDQEFAgEBHoJcAYIqAzECAQEQBqARA?=
 =?us-ascii?q?YFAAosgfzOBAYIJAQEGBASwFxiBIIEeAwYJAYELLYNbhCYBiXqCT4E8DAOBB?=
 =?us-ascii?q?oFvPoJLFwEBAoElOYNbgmeJa4VJBzKCK4tMKoEICF6Bbz0CDVQLC2OBFYEog?=
 =?us-ascii?q?R8CAhEnExQFRXEbAwcDgQQQLwcEMh0HBgkXGBclBlEHLSQJExVABIF4gVMKg?=
 =?us-ascii?q?QY/EQ4Rgk4iAgc2OBlLgmYJFQw1UHgQLgQUGIETBEslHxUeNxESGQ0DCHsdA?=
 =?us-ascii?q?hElPAMFAwQ2ChUNCyEFVwNIBk8LAwIhBQMDBDIEDgMZKx1AAgELbT01CQsbR?=
 =?us-ascii?q?gInnx1xggdGATwtJSsvJX0JbgaWAQGMAqJYB4IxgV2LfohKjEAGDwQvhAGTI?=
 =?us-ascii?q?jeSAYdmkESNYJRyhUcCBAIEBQIOAQEGgXolgVkzPoM2TwMZD44gg3SPe0EzA?=
 =?us-ascii?q?gkwAgcBCgEBAwmCOYY1gloBAQ?=
IronPort-PHdr: A9a23:OVng/BPdt7ZzSYEeqDAl6nZKDBdPi9zP1nM99M9+2PpHJ7649tH5P
 EWFuKs+xFScR4jf4uJJh63MvqTpSWEMsvPj+HxXfoZFShkFjssbhUonBsuEAlf8N/nkc2oxG
 8ERHEQw5Hy/PENJH9ykIlPIq2C07TkcFw+6MgxwJ+/vHZXVgdjy3Oe3qPixKwUdqiC6ZOFeJ
 Qm7/z7MvMsbipcwD6sq0RLGrz5pV7Z9wmV0KFSP2irt/sri2b9G3mFutug69slGA5W/Wp99Y
 KxTDD0gPG1w38DtuRTZZCek5nYXUTZz8FJCA12bsUDKYL7xiAfC6/FX8Ri5MfXRcrxpfxWQ8
 4JgUyC4jHpcKGEY2zjLrvNN2fE+wlqr8hBehNXxMI6IDKBaQvr0XdImQERKY+NvchR4D9j/Y
 ZEPXslGJ8IH8ZKknmsErxqgJCXzWt/pjQRCpSDK/LQo/+AGUjrC/DQwMYsVtUTJo9DXMIsIa
 cOazvLYnBD5LKlW9TL61LboKRcvhPeqfqJxbteO71cyEjr5sHeVp9XFHz27+Nk16Xi+68Fea
 /mgmmAE8gp1+TrxyMkQoNSWn9sc5nHpyAwiz6QwF/y0GBsoKc7hEYFXsTmdLZczWM45XmV07
 T4z0aZV0XbaVC0DyZBiwgLWR9DdLs6G+Bv+UuaWLzpiwn5oK/qzhBe3pFCp0fa0FtK131BDs
 jdfn5HSu2oM2R3e5onPSvZ08kq7nzfa/w7J4/xCIUc6mLCdLJgkw7UqkYEUv1iFFSjz8Hg=
IronPort-Data: A9a23:s8j2iaAV/2VlaRVW/0Tnw5YqxClBgxIJ4kV8jS/XYbTApGwl0zBUn
 2ccWW6HOKmNNDH2c4wjO4WwpkwBuZ7RmtJlOVdlrnsFo1CmBibm6XR1Cm+qYkt+++WaFBoPA
 /02M4WGdoZuJpPljk/FGqD7qnVh3r2/SLP5CerVUgh8XgYMpB0J0HqPoMZnxNYx6TSFK1nV4
 4iq85SAYAXNNwNcawr41YrT8HuDg9yv4Fv0jnRmDdhXsVnXkWUiDZ53Dcld+FOhH+G4tsbjL
 wry5OnRElHxpn/BOfv5+lrPSXDmd5aJVeS4Ztq6bID56vRKjnRaPq/Wr5PwY28P49mCt4gZJ
 NmgKfVcRC9xVpAgltjxXDFDCHtxPe5/p4XZBn6nifzLklabT0nFlqAG4EEeZeX0+85sBH1Ws
 /EIIzBLYAqKmuS2x7y2UK9gi6zPLuGyYdhZ6y4mlG6IS698HvgvQI2SjTNc9DIxjcBHEPKYe
 McYciFHZRXbbhYJNE0eFZQ+m+mlnD/zflW0rXrM9fBtvTONkFYZPL7FLseFKv+SSJlusm23p
 VDK0F/5AilFO4nKodaC2jf27gPVpgvyXI8CHbu0++RChVyTz2gSAwwQE1C8pJGRgFS3RtRSM
 WQX9zAooKx081akJvH0RAGQo3OeuBMYHd1KHIUS5AiLy6fQyweeCWUNVDRGeJogudNebTUs2
 kWInvvqCCZpvbnTTmiSnp+RpCmuOC5TKWYfTSsFSxYVpdXuvukblRXJQf5gHbSzg9mzHiv/q
 xibrDMWib9VhskOv425+lDBxTylvYTARAMz6i3YW2uk6kVyY4vNT4+w8lnd4vZoL4uDSFSF+
 n8elKC29+wAJZ6KkyOJTaMGG7TBz/aMNznBhnZgGJ4u8znr8HmmFahS5zVlLW9qP9wCdDuvZ
 1Xc0StI+ZJVIHqsRa5sZJy4D8ks0e7rEtGNfu7VdN1mcJV3dRHB+CBoeF7W2Hri1lUv+Yk1I
 Zmzb8mhFzAZBL5hwT7wQP0SuZcvxyYj1SbQSIr9whCPz7WTfjiWRK0DPV/Iafo2hIuAoQPI4
 5NRLMeH1RhbePPxbzOR8oMJK10Oa38hCvjesNBYbOeJLxBOBWs8DePMh7gmfuRYc799z7qTu
 yDiHxYHmR+m3yKBNwDMYTZtcrryW5Z4o38heyAhVbq150UejU+UxP53X7M5Z7A68uxkw/NuC
 f4DfsSLGPNUTTrbvT8aaPHAQEZKKHxHXCrebnr3Uyt1ZJN6WQ3C9/ntewalpmFEDTO6uYF66
 /es3x/SC8hLDQlzLtfkWNT2xXOIvF8ZhL1TWWnMKYJtY0nCytVhBBHwqf4VGPsyDyv/6AGU7
 CuoJCsJhPLsptY1+ebZhKrfoIaOFfB/L3VgHGLazOiXMw/G8kqK3L1wUOSBVm3YX2baoa+nZ
 ftnys/tFPg9mHdLrItOPLJ5xo0u59bUhuF7zyY1OF7pfliUGrdbDX3e5vZ2t4pJ3a5/hQu6f
 mmt6+tqE+yFF+29GWFAOTd/SPqI0M8lvwX77NM3ER3c3zB29r/WandiFUCApwIFJYQkLb5/5
 /kqvfMXzAmNihAKFNKipQIM/kSuKk0waYkWhqs4MqTK1DVykkpjZKbCABDY+JuMMtVAEnc7K
 w+u2Zbtue5u+VrgQVESS179hfFQlLYfiiBslVUiHWmEqvDBp/0w3SBSzwgJcxRo/k1H/t93a
 0dWNBxTBKSR/j1XqtBJcEKyFipgWhCI2EzD5GEYtW/eTniXUn7/E0ggC+Cv/EwmrmVWJApf9
 7DFy1TecC3Lefvp1XAYQn9VqP3ETP1w+DbdmcuhId+3IpkibRfhgY6sfWAtqSa7MfguhUbCm
 /ZmzNxwZYL/KyQUha8xUKue6pg9VzGGIzZkbcx63aZUA1zZRi6+6QKOJ2+1ZMlJAf7Aqm28K
 s52I/NwRwaM7zmPoh8bFJwzDedNxtBx3+U7e5TvOWIimJmcpGAwsJvvqw7PtFVySNBqycsAO
 ofdcgyZKVOphFxWpT7pjNJFMW+Gc9U7dFXC/OSqwt4oSbMHks9RKH8X7JXlkUmRAgVd+zCsg
 DjifI7Tluxr9pRtldDjE4JFHASFFunwX+WpriG2ncxFN+3NFcL8pjIllETuEFVTD4swRuZYq
 LWpm/z01XPjo7wZfT34mZ6ANq8R/uS0frNdHfzWJUlgvxmpeZHT8Tpa3E7gMr1PstdWxvf/d
 juCcMHqKOIkAYZM9kNaew11Mkg7CZ2uSozCuCnkjfCHKiZF4Dz9NNn9qEPYNzBKRBQpZa/7J
 BT/4cu1x9Ziq49JOh8IKtdmD7J8I37hQaEWTMLwhxbJEliXhk6+hZW6mSoC8T3rDly2IPT+6
 7/BRTn8c028hviZhpUR+Yl/pQYeA3tBkPE9NBBVscJ/jzehSnUKN6IBOJEBEYtZiTH2yIq+X
 jzWcW8+Em/oaFyoq/knDAjLBW9z3tAzB+o=
IronPort-HdrOrdr: A9a23:OIhONKkohD6frXVdjzI5OQ+l7vnpDfO0imdD5ihNYBxZY6Wkfp
 +V88jzhCWZtN9OYhwdcLC7WZVpQRvnhOZICPoqTNGftW7dyRSVxeBZnPffKljbdREWmdQtsJ
 uIH5IOcuEYSGIK8PoSgzPIY+rIouP3kpxA7N22pxwGLXAIV0gj1XYDNu/yKDwGeOAsP+tfKH
 Pz3Ls/m9PtQwVyUiztbUN1IdQr6ue7364PJnU9dmoawTjLqQntxK/xEhCe0BtbezRTwY06+W
 yAtwDi/K2sv9yy1xeZjgbontlrseqk7uEGKN2Hi8ATJDmpogG0ZL55U7nHmDwuuumg5Hsjjd
 GJiRY9OMZY7W/XYwiO0FHQ8jil9Axrx27pyFeej3emicvlRAgiA84Evo5degux0TtXgPhMlI
 Zwm06JvZteCh3N2A7n4cLTah1snk2o5VI/jO86lRVkIMUjQY4UibZa0FJeEZ8GEi6/wpsgCv
 NSAMbV4+sTWU+GbkreonJkzLWXLzsO9y+9Mwg/U/GuontrdCgT9Tpb+CVfpAZNyHsFcegE2w
 yeWZ4Y0Y2nTactHNVA7ak6MI+K41f2MGfx2VKpUCfa/Z48SgDwQr7MkfwIDbKRCdQ1Jd0J6d
 P8bG8=
X-Talos-CUID: 9a23:JFGSNW1qPs98W0MbqGUsObxfAdt/fX2e9SjqPWi+EV5ZEOCOFGOi0fYx
X-Talos-MUID: 9a23:pY1SEASKvAnWylkbRXTymWEyF99lv5+CI28Oo5kpgMmEDXN/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,180,1684792800"; 
   d="scan'208";a="182263642"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaDD25.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 17:50:35 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 17 Aug 2023 17:50:34 +0200
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.173) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16 via Frontend Transport; Thu, 17 Aug 2023 17:50:34 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URPiUirnLQRcfxZo9ydYATOL5uo+Mu+4Kjn/IB0yXHQYjTGlOf6yWbX2SiKk3SCA4OkqD61pQQCk91n8zsN50EwDLX2R+DHqk6xigqrQOfhE0+lc3HfTDoRqN2tcwpuR3v57Q//j0ugCkOTDBeXtIvVtbMp5wUeXMF8mjOg3A8IfOBuG8rBkAlDXsDUB3ZfgvL04ixoX3wVJT7xpfyOCjZBN+SXkQKZEk6MF76vbrhdbXmVUBmKwCnoMmbcQLBZpOo/Leh1DFg4uluEUSexgsiBZEzU4L/ohPe9yqcEl+ffR5aisQOb5romRbimCLaw+aaDKPgdLVD94BsXJk6gxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=659XVAhRDP5sBAYKdPOWd5NIZtMcsW8l53w7IC1tLWU=;
 b=bRuqjQAogh0XE1wNo4KiUPXMyqtkm+TlW5mDJMtgmONLLfpzlOVH3hPKXWOIuf3MgxfFVEk+LrRk7cxaLcH5h5RvsJI3u7vzaxmXpjdQBSC9y3I3F4DFpQjFwjzgki/o+GftvVNZM/lkMZpQC+sWn6ccij1SjWT+LeA6V7dzX/SfkeDdBt46IfDGrfibR75LeSQJ5pbUKBrfXaAcPw8O2h6IHqQqrdwxtTL//bBvHXj3VrAkLGpawepq+q0u03Nf2+zGdTclB7yyP5kZTGs5b0GBMhzkmIO0QOSYHQMJeuQGgh+evsHR0mMfK750zZkasqe7wL49X2+mdzH1WDewGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=659XVAhRDP5sBAYKdPOWd5NIZtMcsW8l53w7IC1tLWU=;
 b=dI/3M8guP2LT1AHiTmFcUMVMPQe3+frh9K/rL76s1QXbjivID76Tn/SbK7TIqzDlO+SlHPxF1smXugmJlDrPKGj3x9MR+2hDmoTVH3ofMnNKxiwu7NvumQTVJmf1HHfFFUP2xMlCVVsgyfK1cl3j6ffTB57q1aDIEUA3gJmZId8=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BEZP281MB2933.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 15:50:32 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::70d:507d:9c8f:cc3]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::70d:507d:9c8f:cc3%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:50:32 +0000
Message-ID: <f83fcb85-9761-edbb-8378-7b9b029f9c03@aisec.fraunhofer.de>
Date:   Thu, 17 Aug 2023 17:50:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
Content-Language: en-US
To:     Alexander Mikhalitsyn <alexander@mihalicyn.com>
CC:     Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <gyroidos@aisec.fraunhofer.de>,
        <stgraber@ubuntu.com>
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
 <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
 <CAJqdLrpwzbx1bGyPXTEot7t8XpWF4dJAr+8kxuCXjOaSNrfx+Q@mail.gmail.com>
From:   =?UTF-8?Q?Michael_Wei=c3=9f?= <michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <CAJqdLrpwzbx1bGyPXTEot7t8XpWF4dJAr+8kxuCXjOaSNrfx+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::14) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|BEZP281MB2933:EE_
X-MS-Office365-Filtering-Correlation-Id: e910b56e-9e40-43e0-bcaf-08db9f39b06a
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZR+ziVpntfh4F+cgg9VVxT2yC+StjtXQTTW4tdbU+lnylSrXKKEkqKM2C6MHm63COObjN4KA2e+5y2XeVPPOWFk5GRvLo+C6n1RLcS9k9TYET/ujTzc+E0wyc1vw8y7JxLaZ42JJ5mRKbBde8zbe9DxUg1acRuG6h6OYvbt7kZVHScXAqa8wYPk6ZgBiQCmAsp47VKwtRFiFFm7xNIfGPLDAc2LRxrK0KkFCMOdvMytn5VyYcBVvDfhnc++3qIIYX2tIlwKr16KffNuuseEdWfqfTU7izGbCSJVoFga5/e35gEZLNYt/smPH/cD0l5zGY9YxVxfGMfrXDUHcpBS4LmtX8/UmBH6TrCVbJn+DZDhek7SleAt/KifVmnh7kLXPlrkdNIKwKOq2uxCid0QSxND7hw6g1p9LfLrf5y9LTuAFgeAeuYCOPr0CNO3F+B1BXWcfyXcQL+p/K8jfE/31DrSIGzaNBHOtH8DRKfsIp8C1sflij9DTeQLOMjJZtyEosfvWj5wsD5Rm5tWOE2ndCUWcJNI6li9ckA7jKzE8gMPZKOF2ZUAaTSyy8BZrMqWz00eaZKLmzq4Ax2T291hWGmOSEBuRJeAUJQQlSGaAd6+G2/Rth8AnYloYCCzPVEtNPRqUNh/IpN7T/gNR3s5LIcQ9pwBiJPAVJ1pUvTiyBDi/hXBfqSO2BrX25BqD+aSJY5ltjIlR45/UCmhhtatKPwHruJzI1DOs+SYaXJIN7mlGUUqRzsZ2Cd56B31sXse
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(186009)(451199024)(1800799009)(2906002)(66476007)(66946007)(478600001)(66556008)(38100700002)(54906003)(82960400001)(316002)(6916009)(966005)(7416002)(5660300002)(41300700001)(8676002)(83380400001)(8936002)(4326008)(6486002)(6512007)(6666004)(26005)(53546011)(6506007)(2616005)(86362001)(31696002)(31686004)(12101799020)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUd5ME9zR1VKVGZWS2IvUnJCbndqa1MyQnFlTUhkbkp4YUE0SERWNmFrTC9R?=
 =?utf-8?B?SndzbVlpemRDNnJoR3VoK1RLUTZ6emR4ckVoRkZmUk1zYVJkNHVQdjRyQmEv?=
 =?utf-8?B?Qi92QndySG1MZFhGL1psamluT0FjWXNMdHJiZTIrOWY2QnNpd3IrejNVb2JC?=
 =?utf-8?B?eFV6bnIvZjMwUEx5dzJVWXliRmZEUGNOZmNSRlZTVHhlUXNGUkRiSlBITVQ4?=
 =?utf-8?B?SHVlYXVnNi91aGRJb1pyTTFYeDcwTXIybWNFdkwxYnhWaDUzdDBmcUEwcXBl?=
 =?utf-8?B?a2lmMElJQnRpbnBpbFBjcGdERlhUTWxnajdKTVVKQ2h0d2YzTC9paFdORGgx?=
 =?utf-8?B?SVh5VGs0RU51Ym1RUlV4NnV2NXlZMGIwYWR3cGMzUmFNMGN1Y3Y2bEtNRjNW?=
 =?utf-8?B?L0tGSjZrSEVNV1RkLy9BNGExdGUyeFZGVlppdmVYeFoyMG9WalN2NUlKRnlx?=
 =?utf-8?B?a1NmOVQ2ekhoQ2p6VEVCN0hXRVo0V3psbHltWDFKVTRwZFZacTVpd3lORUhB?=
 =?utf-8?B?NjVmbW1Rc2VSazhibWp5TmxkVkdLZ0tJY0NHZ2pHSUtoaWpFM0dTODlvaUpq?=
 =?utf-8?B?Zk01akhkUThwU1U3RXNMYUlxYzB0ejdOeXNXaDhIVllVOUN5aFQ5OVkvNi9w?=
 =?utf-8?B?UXNLTGsybGpyRzNiVTc1MXVyOFdUelR2Wkdvd2k0c2JZZDh2WHd2REppeTM2?=
 =?utf-8?B?b3VkRGJmb2tBcU00ZUxReUVaZzJ1YWlrb0t4c0lVN09ObWJpNEk2K1VoSXRy?=
 =?utf-8?B?d09wQ2cxSDd5dHRrMXhCRWJtTmEvTmhXbFJlallIT0dhWmRwejd4Rk1wZkRQ?=
 =?utf-8?B?YzEzSDNjUnRiK3NsN0RQUmMxYloreGg5OTVPYXo1SUdaRjd2Qmh3dW9pL3lY?=
 =?utf-8?B?bzhzZVdKUVBTSEcxQzBMNU5QTkNwbEF6U1BZVlE1cWhqK0R6TFFkL2VGMndh?=
 =?utf-8?B?NGFJTXZtQWhFeHB1NmJaQURKNTRJOTBLK0I0UDBSd25iMnZ4REVOMnczdFEv?=
 =?utf-8?B?V1F0MWQ1RVRwckdXRGd4dmtSSDhDN25ML0I2dEVxa0lIRU1UTjFWQXFBRklr?=
 =?utf-8?B?Q0tndUg2RmZxZUhCWTNjUFkybkdlRTZLbkxDaE1ER2RNLzhCZmMvKzdaMnNa?=
 =?utf-8?B?T2kxcEh5bFpLaTlYdS8xc1hjMHpWUitOaFNNakdVYzUrcEdCbmJEdkFFL3JD?=
 =?utf-8?B?MFI5ZUkzUUtLRGtZeTRtaDBlakkvcU5LR1JqampLdGFWc05teXVKZFhjM3dw?=
 =?utf-8?B?YWh1WTEvOWhFYjRHNnh2dVR0cnNucllncFZYNWxpWG0rQkhOcjdoQnlydlFz?=
 =?utf-8?B?YUI2NkNuaDJOOHNjR2libUdkSkJqM3RVYlV1OGRHNHhpbHdEQkJDS0txUE9O?=
 =?utf-8?B?bzQyU1NtZkdBaURDWWsweDdsTXE5UU5tUEJoWnl0M1JPNXA3SEQvOFpmUGZu?=
 =?utf-8?B?bndDWXMzYmU4Vi93WGY1aitIOUFaMHoxd29jcTF6ZnJ5c2FtSG5QeWMzN0JZ?=
 =?utf-8?B?dHlrbFZYcWFNYVBKVjBheUdXZ2VtK3RuNTZzc0tCM0V1ajNzRmd6THVtSXRj?=
 =?utf-8?B?UnM3bmRsR0NxSCtlSmtWT1BleDlpRjdUaE1FV2JKNXhyN1pZTVM2NGZ5SjhB?=
 =?utf-8?B?bFNPa21IYVdkZWVHSnFRZHBCZkh2YkpMNXE2bWgwaFJKWVpaUlpJNXF3Z0Vo?=
 =?utf-8?B?Z2dxZE1qSm50QVBsZGZyMytLMW1NNEJvbmFiVE1odXUvUFdkRnJoR0xXcDZj?=
 =?utf-8?B?dnpuY0ZIMndoZktwVTZlV0JJRjluZ1B4LzBIREMvTytQUFJsU0I0L0UwZXF6?=
 =?utf-8?B?UW0wY0lnb1VYR3h5YlkvK2ZwR1F4cThNamkycE5DSUZFRlNQUWZYeEhVaWRJ?=
 =?utf-8?B?UG1UWHpFTnNWRHhYVXFabFVpS1ZwcGpvRDA5UXVzdE0wZlUyd0lpL3N0ZEVy?=
 =?utf-8?B?OE0zaWZtNnkyTmsyMyt1dTN3MjZ3aWFBdERhaG0zMnBMNms5ZnQxbmNjZTFz?=
 =?utf-8?B?TS9HazkrZEhveTByQko3YnJyYnVueVU5b3BSMUZ5NldQNC8vbUdGSndzUE1C?=
 =?utf-8?B?bjNaSjEzWmh1RXlOcm11a05HWjhDUkJGa3FaYkJjK1hMUkw4TUljZ2NJb0Jp?=
 =?utf-8?B?NnZYZWVjRnl1NkVMMFRDMHZpd2NJdlhldGduMXBrOUZBZW5UbWRkYjM3dlAr?=
 =?utf-8?Q?AGmigBXV4ES98vfOoBcEmZs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e910b56e-9e40-43e0-bcaf-08db9f39b06a
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:50:32.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+4qWp/x7SCnZDblZhS9sBbtxweThMNtriDal6NvEslgOCjlF9ORWpEJqSGga2tX+nbLlruXX4XyNDpJWRb4nHDX2P+M0Cu5N2scycTW92ZRfTIZ4Qlc5oMuNJQImrVa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2933
X-OriginatorOrg: aisec.fraunhofer.de
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.08.23 17:54, Alexander Mikhalitsyn wrote:
> On Mon, Aug 14, 2023 at 4:32 PM Michael Weiß
> <michael.weiss@aisec.fraunhofer.de> wrote:
>>
>> Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
>> which allows to set a cgroup device program to be a device guard.
>> Later this may be used to guard actions on device nodes in
>> non-initial userns. For this reason we provide the helper function
>> cgroup_bpf_device_guard_enabled() to check if a task has a cgroups
>> device program which is a device guard in its effective set of bpf
>> programs.
>>
>> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> 
> Hi Michael!
> 
> Thanks for working on this. It's also very useful for the LXC system
> containers project.
> 
>> ---
>>  include/linux/bpf-cgroup.h     |  7 +++++++
>>  include/linux/bpf.h            |  1 +
>>  include/uapi/linux/bpf.h       |  5 +++++
>>  kernel/bpf/cgroup.c            | 30 ++++++++++++++++++++++++++++++
>>  kernel/bpf/syscall.c           |  5 ++++-
>>  tools/include/uapi/linux/bpf.h |  5 +++++
>>  6 files changed, 52 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> index 57e9e109257e..112b6093f9fd 100644
>> --- a/include/linux/bpf-cgroup.h
>> +++ b/include/linux/bpf-cgroup.h
>> @@ -184,6 +184,8 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>>         return array != &bpf_empty_prog_array.hdr;
>>  }
>>
>> +bool cgroup_bpf_device_guard_enabled(struct task_struct *task);
>> +
>>  /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
>>  #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)                            \
>>  ({                                                                           \
>> @@ -476,6 +478,11 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
>>         return 0;
>>  }
>>
>> +static bool cgroup_bpf_device_guard_enabled(struct task_struct *task)
>> +{
>> +       return false;
>> +}
>> +
>>  #define cgroup_bpf_enabled(atype) (0)
>>  #define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx) ({ 0; })
>>  #define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, atype) ({ 0; })
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index f58895830ada..313cce8aee05 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1384,6 +1384,7 @@ struct bpf_prog_aux {
>>         bool sleepable;
>>         bool tail_call_reachable;
>>         bool xdp_has_frags;
>> +       bool cgroup_device_guard;
>>         /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>>         const struct btf_type *attach_func_proto;
>>         /* function name for valid attach_btf_id */
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 60a9d59beeab..3be57f7957b1 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1165,6 +1165,11 @@ enum bpf_link_type {
>>   */
>>  #define BPF_F_XDP_DEV_BOUND_ONLY       (1U << 6)
>>
>> +/* If BPF_F_CGROUP_DEVICE_GUARD is used in BPF_PROG_LOAD command, the loaded
>> + * program will be allowed to guard device access inside user namespaces.
>> + */
>> +#define BPF_F_CGROUP_DEVICE_GUARD      (1U << 7)
>> +
>>  /* link_create.kprobe_multi.flags used in LINK_CREATE command for
>>   * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
>>   */
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 5b2741aa0d9b..230693ca4cdb 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -2505,6 +2505,36 @@ const struct bpf_verifier_ops cg_sockopt_verifier_ops = {
>>  const struct bpf_prog_ops cg_sockopt_prog_ops = {
>>  };
>>
>> +bool
>> +cgroup_bpf_device_guard_enabled(struct task_struct *task)
>> +{
>> +       bool ret;
>> +       const struct bpf_prog_array *array;
>> +       const struct bpf_prog_array_item *item;
>> +       const struct bpf_prog *prog;
>> +       struct cgroup *cgrp = task_dfl_cgroup(task);
>> +
>> +       ret = false;
>> +
>> +       array = rcu_access_pointer(cgrp->bpf.effective[CGROUP_DEVICE]);
>> +       if (array == &bpf_empty_prog_array.hdr)
>> +               return ret;
>> +
>> +       mutex_lock(&cgroup_mutex);
> 
> -> cgroup_lock();
> 
>> +       array = rcu_dereference_protected(cgrp->bpf.effective[CGROUP_DEVICE],
>> +                                             lockdep_is_held(&cgroup_mutex));
>> +       item = &array->items[0];
>> +       while ((prog = READ_ONCE(item->prog))) {
>> +               if (prog->aux->cgroup_device_guard) {
>> +                       ret = true;
>> +                       break;
>> +               }
>> +               item++;
>> +       }
>> +       mutex_unlock(&cgroup_mutex);
> 
> Don't we want to make this function specific to "current" task? This
> allows to make locking lighter like in
> __cgroup_bpf_check_dev_permission
> https://github.com/torvalds/linux/blob/2ccdd1b13c591d306f0401d98dedc4bdcd02b421/kernel/bpf/cgroup.c#L1531
> Here we have only RCU read lock.
> 
> AFAIK, cgroup_mutex is a heavily-contended lock.

Seems legit. So definitely we should do that. Thanks.

Cheers,
Michael
> 
> Kind regards,
> Alex
> 
>> +       return ret;
>> +}
>> +
>>  /* Common helpers for cgroup hooks. */
>>  const struct bpf_func_proto *
>>  cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index a2aef900519c..33ea67c702c1 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -2564,7 +2564,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>>                                  BPF_F_SLEEPABLE |
>>                                  BPF_F_TEST_RND_HI32 |
>>                                  BPF_F_XDP_HAS_FRAGS |
>> -                                BPF_F_XDP_DEV_BOUND_ONLY))
>> +                                BPF_F_XDP_DEV_BOUND_ONLY |
>> +                                BPF_F_CGROUP_DEVICE_GUARD))
>>                 return -EINVAL;
>>
>>         if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
>> @@ -2651,6 +2652,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>>         prog->aux->dev_bound = !!attr->prog_ifindex;
>>         prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
>>         prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
>> +       prog->aux->cgroup_device_guard =
>> +               attr->prog_flags & BPF_F_CGROUP_DEVICE_GUARD;
>>
>>         err = security_bpf_prog_alloc(prog->aux);
>>         if (err)
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 60a9d59beeab..3be57f7957b1 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1165,6 +1165,11 @@ enum bpf_link_type {
>>   */
>>  #define BPF_F_XDP_DEV_BOUND_ONLY       (1U << 6)
>>
>> +/* If BPF_F_CGROUP_DEVICE_GUARD is used in BPF_PROG_LOAD command, the loaded
>> + * program will be allowed to guard device access inside user namespaces.
>> + */
>> +#define BPF_F_CGROUP_DEVICE_GUARD      (1U << 7)
>> +
>>  /* link_create.kprobe_multi.flags used in LINK_CREATE command for
>>   * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
>>   */
>>
>> --
>> 2.30.2
>>
