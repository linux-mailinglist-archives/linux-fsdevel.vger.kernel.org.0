Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF60979BA0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241104AbjIKU46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbjIKKiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:38:54 -0400
Received: from mail-edgeF24.fraunhofer.de (mail-edgef24.fraunhofer.de [IPv6:2a03:db80:3004:d210::25:24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4F0CDC;
        Mon, 11 Sep 2023 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1694428725; x=1725964725;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f6qoMrZmWLwBa0vpqW++X5+seH1w86At9Av4GPPQSzw=;
  b=A1AQMQ+VhKa2MGvAYgckVcB56iEPMN5o9LqjimrqEoI+Kz2ehVvRjuM+
   M9yout0t/GNqhgFVwft1Silj+sWhRZmaKBNO+siy4SMC00XGjuOQDSh2k
   d2bJa30oHKCRj+aAIWG2dG3xRGOMAMvAH50MxWW+4yPhjc8anDlJrerx7
   KIPRdeP24zGnAiX5O/OP3iGGPyFE4fo0bYTGf57ZMWAHdwiqO1ZJatq0M
   spWR7NtObv6bjiQ6eA4+sQ4XBRyGtAIatTez2PNRPx5lCGlrO/njAHAj5
   y5acArd8VS2PnrfiYR4pL5Musw7TN6ZQdYR4A+2HEGdDjWHfhE1tn7vmz
   g==;
Authentication-Results: mail-edgeF24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2FfDACe7P5k/xoBYJlaHgEBCxIMQIQGeIFcBIROkTMtA?=
 =?us-ascii?q?4tckEkqgUCBEQNWDwEBAQEBAQEBAQcBATsJBAEBAwSEdQoChnMmOBMBAgEDA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQYBAQEBAQEGBgKBGYUvOQ2DVoEIAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBHQINKFEBAQEDIwQLAQ0BATcBDwsYAgImAgIhESUGAQwBBQIBAYJ6AYIqA?=
 =?us-ascii?q?zEUqCF/M4EBggkBAQawHw0LgSCBHgMGCQGBEC6DXIQPHgGFUYQ1gk+BFScMA?=
 =?us-ascii?q?4J1PoIggWoYAQE1g0aCZ4lMgi2DFQcygieDXolKKoEICF+Baj0CDVQLC12BF?=
 =?us-ascii?q?IEogR4CAhEnEhMFQnEbAwcDgQIQKwcEMhsHBgkWGBUlBlEELSQJExI+BIFng?=
 =?us-ascii?q?VEKgQM/EQ4RgkQiAgc2NhlLgmMJFQw0TnYQKwQUGIEVBGofFR43ERIZDQMId?=
 =?us-ascii?q?h0CESM8AwUDBDYKFQ0LIQVXA0gGSwsDAhwFAwMEgTYFDx8CEBoGDisDAxlPB?=
 =?us-ascii?q?A4DGSsdQAIBC209NQkLG0YCJ6BsboF7QRkGAiwQHSEUCiFYOQcXHQVhFpJcg?=
 =?us-ascii?q?ywBrWxvB4IxgV2MAI8ThXcGDwQvhAGTJJI6h2eQRiCLTIF1g3WQfoFKcIMOA?=
 =?us-ascii?q?gQCBAUCDgiBeoF/Mz6DNlIZD4EbjQWDeIUUimd0AgE4AgcBCgEBAwmCOYkPA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23:uuoS3BeOZ8yIMqFNkY61fIyLlGM+/N/LVj580XJao6wbK/fr9sH4J
 0Wa/vVk1gKXDs3QvuhJj+PGvqynQ2EE6IaMvCNnEtRAAhEfgNgQnwsuDdTDDkv+LfXwaDc9E
 tgEX1hgrDmgZFNYHMv1e1rI+Di89zcPHBX4OwdvY+PzH4/ZlcOs0O6uvpbUZlYt5nK9NJ1oK
 xDkgQzNu5stnIFgJ60tmD7EuWBBdOkT5E86DlWVgxv6+oKM7YZuoQFxnt9kycNaSqT9efYIC
 JljSRk2OGA84sLm8CLOSweC/FIweWUbmRkbZmqN5hGvYbTBjhPEq+Uh2TOfOcivbLc/GmT+0
 YUyTh3UuhdXFxwh/XGIhst0lPtAkUfywn43ydvyeI6YGOpjQpncIYI7X3dKXOUNTnB5IdORX
 poiAfEsI/xKnpnP/EMs/D3mNBOiDfnFkWBNxVPr46kn7+kjODv00Sd6DtgIm2/+ovjFKYILV
 bnvk7DkkTCAf61T/ivt94nkQzog5uqtR5dxIe3w23QXNSzLjXGMt6LeZxnNyt4QrHS3wbBDB
 c33oTQGiCNWvgb12u4itLbJt5tNl3vnzCB0/4g7JviJb210Rt3xQ9NA8iCAMI1uRdk+Bntlo
 zs+1ugesIWgL0Diqbwizh/bLvGLfIWmuE6lWvyYPDF4g3xoYvSzikX6/Uuhz7jkX9KvmBZRr
 yVDm8XRrH1FyRHJ68aGR/c8tkes0DqCzUbSv8lKO0kpk6rcJZM7hLk2k5sYq0PYGSHq3k7xi
 cer
X-Talos-CUID: 9a23:GIpTSmzDr4qAQXdvkEr1BgUWHPo+ey399E7CMmK8ID5bC+SeUV6prfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AvZTYEQ/hs8r91Z6ICZEkqfOQf95Vxq6gOEU8qJk?=
 =?us-ascii?q?5keKfDhR/PxWWoB3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.02,243,1688421600"; 
   d="scan'208";a="59770170"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeF24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 12:38:40 +0200
IronPort-SDR: 64feee2e_Uq82NuJ+lBgenKqlcuB5r1h4J1aqXM5FofvPzns9Z1REmJ1
 0ZVaGq9K1A149BXXjSiweW7iwMCcOksjnylyMAw==
X-IPAS-Result: =?us-ascii?q?A0A0IgCe7P5k/3+zYZlaHgEBCxIMQAkcgw9SBz00WCtZB?=
 =?us-ascii?q?IRNg00BAYUthkEBgXUtAzgBiyOQc4FAgREDVg8BAwEBAQEBBwEBOwkEAQGEf?=
 =?us-ascii?q?AoChnACJjgTAQIBAQIBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQYEgQoThWgNh?=
 =?us-ascii?q?gUBAQEDEhEECwENAQEUIwEPCxgCAiYCAiERBx4GAQwBBQIBAR6CXAGCKgMxA?=
 =?us-ascii?q?gEBEJs8AYFAAosifzOBAYIJAQEGBASwFw0LgSCBHgMGCQGBEC6DXIQPHgGFU?=
 =?us-ascii?q?YQ1gk+BFScMA4J1PoIggWoYAQGDe4JniUyCLYMVBzKCJ4NeiUoqgQgIX4FqP?=
 =?us-ascii?q?QINVAsLXYEUgSiBHgICEScSEwVCcRsDBwOBAhArBwQyGwcGCRYYFSUGUQQtJ?=
 =?us-ascii?q?AkTEj4EgWeBUQqBAz8RDhGCRCICBzY2GUuCYwkVDDROdhArBBQYgRUEah8VH?=
 =?us-ascii?q?jcREhkNAwh2HQIRIzwDBQMENgoVDQshBVcDSAZLCwMCHAUDAwSBNgUPHwIQG?=
 =?us-ascii?q?gYOKwMDGU8EDgMZKx1AAgELbT01CQsbRgInoGxugXtBGQYCLBAdIRQKIVg5B?=
 =?us-ascii?q?xcdBWEWklyDLAGtbG8HgjGBXYwAjxOFdwYPBC+EAZMkkjqHZ5BGII1Bg3WQf?=
 =?us-ascii?q?oFKcIMOAgQCBAUCDgEBBoF6JYFZMz6DNk8DGQ+BG40Fg3iFFIpnQTMCATgCB?=
 =?us-ascii?q?wEKAQEDCYI5iQ8BAQ?=
IronPort-PHdr: A9a23:rzpmtR8sJSpOOv9uWWy9ngc9DxPPxp3qa1dGopNykalHN7+j9s6/Y
 h+X7qB3gVvATYjXrOhJj+PGvqyzPA5I7cOPqnkfdpxLWRIfz8IQmg0rGsmeDkPnavXtan9yB
 5FZWVto9G28KxIQFtz3elvSpXO/93sVHBD+PhByPeP7BsvZiMHksoL6+8j9eQJN1ha0fb4gF
 wi8rwjaqpszjJB5I6k8jzrl8FBPffhbw38tGUOLkkTZx+KduaBu6T9RvPRzx4tlauDXb684R
 LpXAXEdPmY56dfCmTLDQACMtR5+Gm8WxyVrMzT90gz1Apbrty//78t602rKYfPUFLY2ZQaSv
 4dJUBL41ysAMyZg61CC2akSxKgOhgquqjBv3rLuYd3EFeBjdaH+IcpGfUkRc/dAeiJaL52mf
 bofPbEZH7d+97jnqVIUh0DhAEqAGd3r1wNFhFbM76ARifUrFyrd9gINL88rqXCN9orsGPsXE
 vDryY7U3SrCQ8J82HDmyZLtc0AGgOOxZZBff8n11VcBLFvv1kmqtJP5Ex3P9bQi60LBzslCc
 v6R0XIOpT9Oogm2npoHqbDMi70bxFPhxAJaz6E2cI7wWAt6e9miCJxKq2SAOpBrRt93W2hzo
 3VSItwuvJe6eG0P1J0E7kSBLfKdepWO4hXtWfzXLTorzH5mebfqnx+p6gDg0ezzUMCozUxH5
 jRIiNjCt30BllTT58GLR+E7/xKJ1yyGygbT7e9JOwYzk6/aIIQm2bk+itwYtkGrIw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:7OB3naGUSMGFV1KHpLqE18eALOsnbusQ8zAXPo5KOGVom62j5r
 iTdZEgvyMc5wxhPU3I9erwWpVoBEmslqKdgrNxAV7BZniDhILAFugLhrcKgQeBJ8SUzJ876U
 4PSdkZNDQyNzRHZATBjTVQ3+xO/DBPys6Vuds=
X-Talos-CUID: =?us-ascii?q?9a23=3Ah7jZnGilBdzPpqytA0YWwaz5yjJuXUzCyUzAe3W?=
 =?us-ascii?q?CAn9iUKLWTX7Bxo1Kup87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AsNIflwxDeVF+o5UghCpmeWmM3h+aqJmcWXJVwMo?=
 =?us-ascii?q?th9iVCj4rGAycyw+HYoByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.02,243,1688421600"; 
   d="scan'208";a="63769953"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 12:38:38 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Mon, 11 Sep 2023 12:38:37 +0200
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.168) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16 via Frontend Transport; Mon, 11 Sep 2023 12:38:37 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1OJMNe+8NJiRq2PaUpudxbzcYaqDjATqWHg7Kvkhxo/iY84SKBJ3flbEPzkn4OrvvOwnaTeZX//ZfLSaPrWXXXI+zMepk9c8ajoUHr2ym25ji2EyjUxJDAwP0et+npEgft5Fo9iIRBxyoHGK3rwBA/uQErJYqI9YJfg+ixglLtuGtzY0Q9dxfLVSoGiAeTRcV+CyBWsSrUabfU2KtHWcEbu6C1mXBZBlaGziHl0ifpPSuaf0DwAyklaGbNfsiZGS+0sn6L5C94GGjMS/LDGGQsudHUyTc5UEWcd8n8kgFKH5r9s8D75u5ub8vZOr9Oe5YvuUOnLa91b9iHKs6vaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKXTPVug4irmlm1Ioc+84VJ1njTZX8HJpex7dolp1sY=;
 b=B9UxOEJYtFcxfFf2eIg9EkGilOhwvikhc6PMdWuXTq+6/xR7IcZB5X2l7ttPNh+5L7VBb/Gh8fEmxNHQHsNO43sY5apECWe5/dqqHyFEavTq4h+xHJqu/EsebBAoMk1/6SFyOQ4TElkzLPZE+4aMSUzT9bchIqrWs379jUR3ZEFSmzKYq/xMkdqkOB06cAttDXp1oQWNiOgYrUIpF0ZlI4d4L8acLmFLkjnBmIbIweXQZcndCRJAN0Iq5eugWyKYlaKObYwrfriPTWbx4tPph/VB4/1M2qPvW6Hug/Cjgneu6tmuNWuZGmpoul9vYA3xBtrKwjcNMnfLoAUc0r30Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKXTPVug4irmlm1Ioc+84VJ1njTZX8HJpex7dolp1sY=;
 b=NpgeDxuTRi49IrucjK4q4PK8EYyEfsEvrzYxZ3pJ9N0YrfarB37m+DuVluTejARZeC2ybnCsBfEXuMql127qD4m+x6mOtxwiDYBi/sIrMi8OIzUPJGfkLtvFS0B0tRuwtDF2K8G0B2IKJOtV2tAfVWhYq05CKQmeWffkMYOKgOk=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by FRYP281MB2255.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 10:38:36 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e5fc:9d78:c1e6:e0d5]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e5fc:9d78:c1e6:e0d5%2]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 10:38:36 +0000
Message-ID: <c0a32db6-b798-4430-476d-dc74e9f79766@aisec.fraunhofer.de>
Date:   Mon, 11 Sep 2023 12:38:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
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
        <paul@paul-moore.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
 <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
 <20230815-feigling-kopfsache-56c2d31275bd@brauner>
 <20230817221102.6hexih3uki3jf6w3@macbook-pro-8.dhcp.thefacebook.com>
 <CAJqdLrpx4v4To=XSK0gyM4Ks2+c=Jrni2ttw4ZViKv-jK=tJKQ@mail.gmail.com>
 <20230904-harfe-haargenau-4c6cb31c304a@brauner>
From:   =?UTF-8?Q?Michael_Wei=c3=9f?= <michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <20230904-harfe-haargenau-4c6cb31c304a@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::12) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|FRYP281MB2255:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e88cec-7045-4e41-df2c-08dbb2b340d9
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpMDH6OXgEJTGmCCMYI0qHZUVBuqHJJw1ZR8pquIIfulP8KuLHJGR+3Tua37hiXHSSIaK+mul6UNlLEXqZ44agcuGGEBH7SulhsTK5C/LfjwvHkhHlxL5VJWr61k3UGOaYtEte72AiZjJpkzWoaZONcZFEJxXA8arcXAPd+U66VNmFNYtxZZKutUCN4p6qcbrogfWJVf+OmChOGNqGpVPrKCzvV1BLQAPJfs3qN21Zx1QGAPPq3FhsdlxoiXk8hPBaPiSourm6nXXQVKsf3mToJnb2GwRTHqrlhHTINU3VVnk5fEljRkLCz+VysEKta2rP5sEESd5mX9a9jhIfD9kxtk9sKWLH+PAFGg3Ljhsg/gM78CW0ZTQbkr3m2O0Gc2ikFdtJAzKIvdauaRDI3llSqum7xrFXBAPeXVnYGlZLzQ7q9Fg2hGCKikUTXkpv6JjIEfMn9m8DO3Fs8Exptljq95ufIF1dTUM6zw7Y2PCEHUAFcQeKNEZdsdgrLHlthi1h+vx+xKo9TEi+aQ/rO4pVSS1YkNSRqZZizeR4iu9GRELhj9/273sblqwgfWfVGMjrBXj0EGSqWLcgQ3lm/pbKL2YXOdd1crD2ZPmBn0H/yEI8BQaW3MfnugVmJfDktU0GqfbaNdW2rJK8YYba02dcsdPAlI4dbiProEERERywPf4Su3DLiB92h2KMD9w/kG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199024)(1800799009)(186009)(31686004)(53546011)(6486002)(6506007)(110136005)(86362001)(82960400001)(38100700002)(31696002)(2616005)(966005)(6512007)(83380400001)(478600001)(2906002)(41300700001)(4326008)(316002)(8936002)(8676002)(5660300002)(7416002)(66946007)(66556008)(66476007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ampHZ2ErcTBid294QXFQQjNNYzY1WXdaSlNJM0xVYUlUbkRUUEJXeXBEL2lN?=
 =?utf-8?B?a1g0TGZoZE1oOVVMb1ZXbVFjajZ4aEZLaTd5N3F4UHNPTWVySmoxWjhabGdy?=
 =?utf-8?B?V0dRRFREb2Y4RFF6dTZpcXNoa0VjbkJjVlhwZUVVdTQweUxrMWVBSFFpS25u?=
 =?utf-8?B?T2JrSWFQalI2ZEQrYUdMYXozY2pUZjNKSDc3a2hOQ2VSazVHVzNkNXIrQ0ZI?=
 =?utf-8?B?R0xyalJySEc5YzRNdHBXbHRKZTJ6Nm96VHJHc2Q2enM3TTBPaU1hUXhFV01E?=
 =?utf-8?B?OXBKU3pHUTcrV0lNNUZBZkptSm5SbVEwZytyL0JVSzJaNU5mY2pRb3JUTVlv?=
 =?utf-8?B?SHZBMFhPWXlvZWlTR0JTUVRNMEhDZ244SVFUenUrL2RJODZwcWJuRjU5ajIw?=
 =?utf-8?B?Tk04UmFucWJZc0dIcE1PbVAxWlVxVEZldzZkeHZzUlYrZTdHT0QyTjZvSk1B?=
 =?utf-8?B?cGVReXZhcDh4aURxZmUyU0NrYWc1L0U1WU84MFNsYkJZQ0xwMUZlbTRiVjJt?=
 =?utf-8?B?YlRtWTE5ZG5EN2hWTEE3YVRtbklleHVydktWK1ZaRHBKQkdwQzRGMkJ1SW9M?=
 =?utf-8?B?Q055T1gra0NIdlpNZ0NtRnV2ODFjQm5HOUV3NktOZnNUYlpVWGljSnVGSkV5?=
 =?utf-8?B?NFgyMWtHNnlmQkJQRjdkYzR1aTV5Zkk5czV3L29xbzRTMUN5OGYzVXFDaFRO?=
 =?utf-8?B?NUJIazE5c3pSVEo1ZC9EajU1U2xSVjM4cWxoMTVFeXZTdXNqaHNuTlgvVW1B?=
 =?utf-8?B?NWVGZ3FKZlpJengwNU4wWTZxNzRJZXJQSXh0SWFCU2pyenZJR1VTRHdPa3FF?=
 =?utf-8?B?aVRVaUNZVWZFSXNPVVVvQm5oN0tvQnJHTmxteHoybCtrcEF3TEIzWHRzTEdN?=
 =?utf-8?B?bEM2d3JCai9Vc3dBZWdEdEtwU21PbGdGWXJqMUxWNmk3amJkRHhtWEZFVk5Z?=
 =?utf-8?B?ditEUFI3b1hHM2dhRjdxVXVFVWM3dGVhMkZEWkZtUW9sbHBiRnpyUEhjUnZ3?=
 =?utf-8?B?d2I5US9DSmVOdy92QWUxSXJxUUdlMnEweVBrU2tnRWVhWkwwSUFZOVl3cTA2?=
 =?utf-8?B?VjNRVVV4OHRZamEvandyQVpOWHVBczhtZFpPbVU5RHowRW92ZDZKdGN6STJy?=
 =?utf-8?B?MVZzUVFRQWhzUHhldHl1ck0wTEwrY29XMEc1V1kxaGZUVTBCNTMwMUhneFRl?=
 =?utf-8?B?WFVUUE9PN1RsZjhTekh0anErUWVHU1QwcEJXUDlIT3hsWHJjdWsrcGZxRUIz?=
 =?utf-8?B?MlJtNFV0SWpPRXlxeVNUdjFSZWZVbEppUG4rVk9Pd0M2STdRcllPYUtOVlFT?=
 =?utf-8?B?STJESlNyL0hQbHF3bERZU3o5ZUJUN0R4ekpuVHMyNVBvb0RKUDRxeURqQ3lp?=
 =?utf-8?B?U3NEaXIvdThRa21hUWpSUldMemhKZWNoNURCVWlEdlZ5WWVJWExGRUh2am5F?=
 =?utf-8?B?RmloYWxzRlMvZUJwREZFQkxWMnY4aW5IU2FIZlJSaUJQWGovelN4Qnlwb2Er?=
 =?utf-8?B?OURyMWRvTHVHZDNQK1JHVmhzUmxOckk4M0FUNHhNNVdXcXJjc1dhRjhuZndi?=
 =?utf-8?B?WUZVT3Q0bUFhWlF5WGlDUGd6Rzd4YVJXeldkR3dqa2ppWmpSdzRwV1FRL2k2?=
 =?utf-8?B?ZlYrYWcrbzBqNERNR1J6TlNzSGxNbXFub1FPRElZSkFHeHV0WmJmMzFkMEI4?=
 =?utf-8?B?UjNRdzRnZTdSTVlFYzlIZzFibVI5Y1NDVUhXZkwwdDZaRENMcGZ6c1NQSDNs?=
 =?utf-8?B?QVdmZmFmTDJvN21Pc0xUd2dOR3RQZm9qNFc2bmlGbU4yMy9yb1lRWUE5dmRX?=
 =?utf-8?B?NTZ5UW5Nd2NFRE4vVit3K3NPc0JJdU5FRHRtNzJhSE9VcklPOUNsb3IrUkJs?=
 =?utf-8?B?UU9uQ2VkQ3lvS0lETEVYdytnVXVBRzV2ZGxjZzZ1TXhNY2hZdko5T0pwSllV?=
 =?utf-8?B?RVdlT3NaRXgrQkgrVWlWL0sybDNQVGFOR2dVU0xua1hsUU9xOVNmTlVzVXht?=
 =?utf-8?B?S2lwNWpEYmJ3cFhValhnM2VCeVhndk5PVmlxTjMxbSs5ZzNxS2RKY0xRYmQz?=
 =?utf-8?B?azkyd2haNGozS1NNTU1hYVNaYVk5VUx0c3pOcy9iSG5jaTJ4dEZ6K1l1WDNn?=
 =?utf-8?B?YzE4RGRkcjlsWGllbVhiOGpvZnMvcDV3djBBYURIRVMxQ2VJaWhCTXV3YnNN?=
 =?utf-8?B?eENoZ2x3TWJtUkpvMExkWjV3aUZBWTdjUzI4SXRPa2V1S2k4Qy9WTVdqRnZu?=
 =?utf-8?Q?ohzUJjdIFpz/xCqoUvsMRnv/zrVlpoC6ja+ziLb2vE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e88cec-7045-4e41-df2c-08dbb2b340d9
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 10:38:36.2481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Rk/214V4jUKaRus/AX/kwktPm5dVsDkq76NwXayB1791E+zDFKg1dn6cG7c5x4PEKsFRTyr7SZmO+GxbMe2XWeNNsepJL36sTvJcjrTBzdYuKUdsKTKDJOgXvKyGCFM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2255
X-OriginatorOrg: aisec.fraunhofer.de
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.09.23 13:44, Christian Brauner wrote:
> On Tue, Aug 29, 2023 at 03:35:46PM +0200, Alexander Mikhalitsyn wrote:
>> On Fri, Aug 18, 2023 at 12:11 AM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Tue, Aug 15, 2023 at 10:59:22AM +0200, Christian Brauner wrote:
>>>> On Mon, Aug 14, 2023 at 04:26:09PM +0200, Michael Weiß wrote:
>>>>> Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
>>>>> which allows to set a cgroup device program to be a device guard.
>>>>
>>>> Currently we block access to devices unconditionally in may_open_dev().
>>>> Anything that's mounted by an unprivileged containers will get
>>>> SB_I_NODEV set in s_i_flags.
>>>>
>>>> Then we currently mediate device access in:
>>>>
>>>> * inode_permission()
>>>>   -> devcgroup_inode_permission()
>>>> * vfs_mknod()
>>>>   -> devcgroup_inode_mknod()
>>>> * blkdev_get_by_dev() // sget()/sget_fc(), other ways to open block devices and friends
>>>>   -> devcgroup_check_permission()
>>>> * drivers/gpu/drm/amd/amdkfd // weird restrictions on showing gpu info afaict
>>>>   -> devcgroup_check_permission()
>>>>
>>>> All your new flag does is to bypass that SB_I_NODEV check afaict and let
>>>> it proceed to the devcgroup_*() checks for the vfs layer.
>>>>
>>>> But I don't get the semantics yet.
>>>> Is that a flag which is set on BPF_PROG_TYPE_CGROUP_DEVICE programs or
>>>> is that a flag on random bpf programs? It looks like it would be the
>>>> latter but design-wise I would expect this to be a property of the
>>>> device program itself.
>>>
>>> Looks like patch 4 attemps to bypass usual permission checks with:
>>> @@ -3976,9 +3979,19 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>>>         if (error)
>>>                 return error;
>>>
>>> -       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
>>> -           !capable(CAP_MKNOD))
>>> -               return -EPERM;
>>> +       /*
>>> +        * In case of a device cgroup restirction allow mknod in user
>>> +        * namespace. Otherwise just check global capability; thus,
>>> +        * mknod is also disabled for user namespace other than the
>>> +        * initial one.
>>> +        */
>>> +       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout) {
>>> +               if (devcgroup_task_is_guarded(current)) {
>>> +                       if (!ns_capable(current_user_ns(), CAP_MKNOD))
>>> +                               return -EPERM;
>>> +               } else if (!capable(CAP_MKNOD))
>>> +                       return -EPERM;
>>> +       }
>>>
>>
>> Dear colleagues,
>>
>>> which pretty much sounds like authoritative LSM that was brought up in the past
>>> and LSM folks didn't like it.
>>
>> Thanks for pointing this out, Alexei!
>> I've searched through the LKML archives and found a thread about this:
>> https://lore.kernel.org/all/CAEf4BzaBt0W3sWh_L4RRXEFYdBotzVEnQdqC7BO+PNWtD7eSUA@mail.gmail.com/
>>
>> As far as I understand, disagreement here is about a practice of
>> skipping kernel-built capability checks based
>> on LSM hooks, right?
>>
>> +CC Paul Moore <paul@paul-moore.com>
>>
>>>
>>> If vfs folks are ok with this special bypass of permissions in vfs_mknod()
>>> we can talk about kernel->bpf api details.
>>> The way it's done with BPF_F_CGROUP_DEVICE_GUARD flag is definitely no go,
>>> but no point going into bpf details now until agreement on bypass is made.
> 
> Afaiu the original concern was specifically about an LSM allowing to
> bypass other LSMs or DAC permissions. But this wouldn't be the case
> here. The general inode access LSM permission mediation is separate from
> specific device access management: the security_inode_permission() LSM
> hook would still be called and thus LSMs restrictions would continue to
> apply exactly as they do now.

So are OK with the checks here?
> 
> For cgroup v1 device access management was a cgroup controller with
> management interface through files. It then was ported to an eBPF
> program attachable to cgroups for cgroup v2. Arguably, it should
> probably have been ported to an LSM hook or a separate LSM and untied
> from cgroups completely. The confusion here seems to indicate that that
> would have been the right way to go.
> 
> Because right now device access management seems its own form of
> mandatory access control.

I'm currently testing an updated version which has incorporated the locking
changes already mention by Alex and the change which avoids setting SB_I_NODEV
in fs/super.c.

Does is make sense to send out a v2 to further discuss BPF related changes?

Thnx,
Michael
