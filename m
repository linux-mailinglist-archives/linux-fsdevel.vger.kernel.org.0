Return-Path: <linux-fsdevel+bounces-1233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7967D80DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 12:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687B11C20E9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C912D78E;
	Thu, 26 Oct 2023 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="qCamM+jR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2D2D05B;
	Thu, 26 Oct 2023 10:36:18 +0000 (UTC)
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2092.outbound.protection.outlook.com [40.107.121.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225FD189;
	Thu, 26 Oct 2023 03:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG0Fshx/Vhb6O/6MuRCRvPEG9hYyTIL+UHDynBeaNYzXAC0ZLwYZ9ZpGX/FlIn9+K0pHUh46CADlTgMi6GLi2aD+TjNB42zwN6M1aFOAwTZENbnbsrMnZaDijykP8oEt3Dj9CJant9s0E+oNTpLSVLfAsevWnK/pTE1vZZeE133WYNkH2dsOG8qznUZ/IYt3hbZLchT9Sq+p4Y9GjbMphsEbls7/WmBwypEUFLj/lR7u5gBR1gW9D7e8GK0cHgp2eReNgM7oNCF4VkDaCParUktcrI7yiW2VIRA4DEjOnNfYRgsByqSGFXv2bNg/bdqm8MogLQ9B3qg6YLySG1ZZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHfwMIwJc6un10nuK1mblB0eOJMlqa7OBIEYvuwUhdA=;
 b=eX44g7P/QdxFk46yECytgYydkFAMGxyQ9KxVPoGuH0IXIKtDlHZLoEqLYongJjYD48d4Ocr+ZNnrrFmKmzo+Hx+x8CVCJZD3YzAPGsYPegSUkssJ8kKSm7bz+QTc0bhdAMjwYH18g0gJjdZRRs/DdOyWKLBlH72Otq6GbCtlVTSSf2aQO/Qsm1qPyGJBKMr5E88h3KFQkyh0wwv5+oYpZc4/Hd/GM2+4NPPAjqCv1Oc+PPiXtNsif38LYmv8AO/a5S7pjMS2aEi0CYLiUZUSk/kzsEDfVg5CHjhgTFQE8anWmBQN6z2gEzWyxNmt8YZSZwfCaJjzwXACrRIWddOTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHfwMIwJc6un10nuK1mblB0eOJMlqa7OBIEYvuwUhdA=;
 b=qCamM+jR6okZA9mHUY3Y6e2PtWYXNPj2jo7pAAE4Bwr8u7DJFDBxLSIDsREa0YKogOW+ek2uG/eTthlZ2InubEAmBsUF5aji/CabGqvkOSQzwQQbREnCLkiTP4sWwMtLwOoFrUCIyO+tXV5LEa02U3PdeEz4+S3D7SCgrtQ6pfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5407.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:245::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 10:36:14 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6331:81d5:43cc:a9a2]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6331:81d5:43cc:a9a2%6]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 10:36:14 +0000
Date: Thu, 26 Oct 2023 11:36:10 +0100
From: Gary Guo <gary@garyguo.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice
 Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea
 Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade
 Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul
 E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes
 <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 elver@google.com, Matthew Wilcox <willy@infradead.org>, Dave Chinner
 <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [RFC] rust: types: Add read_once and write_once
Message-ID: <20231026113610.1425be1b@eugeo>
In-Reply-To: <20231026081345.GJ31411@noisy.programming.kicks-ass.net>
References: <20231025195339.1431894-1-boqun.feng@gmail.com>
	<20231026081345.GJ31411@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0552.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: c03f7c35-f11b-4491-9734-08dbd60f60f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qZPEXaGrl03SQklEBTw1rWSVoO6BPKV6EAxbL6+pnDd4oM7Cq/D0bBZYc2Zpwdv33usECNuKJVu9qanGuyh99ZG1llh6juGYFUAAcQS9nMondYFCex71BiAea6cwU+vO7R38CMKCNGtpeIK+piv6HFvexv1ww1w+xBNguFDQRBmhno3m+vLTPjkUmulZ2BxFlToe1ry8V6q14JJKo3Fv3QpAcJQWFhN3d1bdx4pzgLd3JDjP09ckLtQW+nU4Grs1MZ/PbFQ33Ahsh9gcifwMRHTsQ5qIo9JsTaS6CUq2nJsr2C7fop1mZQUOHES/druPOcUYcC27eYkWM95ytaaMtMqgayHt8cXxW48tM3sQUXu/krZVEgAv3Yf2yy7tz0dahlcr5/Szc89o8J9/osv63Pz1iTyatMwr6m5H9EiTWxfxVL67CmducE2levCPwZhU67LmkvdiZHWsIbmK09bPdRf3eMaQm8SLAF6Ho2hi9oezaILUuIUStbMQakWxnXhrgouZCSvc0eRwkPQIgtGOKHh/pWAT9CukqcSBpRd3KFkZDph/+QDP6n2Ppidm0tiQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39830400003)(136003)(396003)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(41300700001)(8936002)(8676002)(6486002)(4326008)(7406005)(86362001)(7416002)(2906002)(478600001)(5660300002)(54906003)(66476007)(66946007)(316002)(66556008)(6916009)(33716001)(6512007)(26005)(1076003)(83380400001)(9686003)(38100700002)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1qm6QcojY0Pw4/OXoN7TPsgKSthuxNwSig/Dso/q8GEQIzFKtAf1qTAXrYal?=
 =?us-ascii?Q?jFATVLiecR6sQ2t3tPXf68lAtoPkp10VZo2u3/3Xd/PAFYJ+7fDsCz/XVQ6J?=
 =?us-ascii?Q?ztFiLvyTw4F37Ywz/lZ+g0sleFKv08pVhkHNCLZxY2dFOrZID3DRS/csJG5M?=
 =?us-ascii?Q?iokkC0IVWf5Hvyd6acs8DVxWvvYz7L5KiKgooFmNXKzvxcEkdfvGMEeP7gI8?=
 =?us-ascii?Q?1kewnQBY0c/D7GA90HvNXnU661oSsdcq5rxWjvOPWwyN4JFzTad8LUlyBBd3?=
 =?us-ascii?Q?o+yi2pwdozRdLp8LPSuF05GE3iaz04C0+a7ejbrwyD9VVzGb8VdvoOg1WuSU?=
 =?us-ascii?Q?BIRn4CSntKFFLDAIELH5GXGjnxZeSIBa/I25sZp6/zHiSn0xHk4KRFOYb0g4?=
 =?us-ascii?Q?3qJJbhwMrr0NQvSaHIOtODFWEo9bFb8nhZHxjD3rJyaNHEhMXkq2EuUPdi5Z?=
 =?us-ascii?Q?w6j/8eAsj+eQ/ayBoOUxJQrLXrhzk9VyhrLLUZboEKxp5FuQ4h42trJxhSBg?=
 =?us-ascii?Q?+p7dbtkkxmw04LxWagAuvSAHKYLxKEAk2y0H293FfVfks7x7Z/bKK4cYNCPF?=
 =?us-ascii?Q?ifkUe3oxUg0tNHhi9Ed55zKd/MFbYPq2jmshv0raKunz2LUl25N7yhpYttLq?=
 =?us-ascii?Q?GlRm+Y5f0bM489daygaUHWv45B7IqUi72iMXLsgJ0csCENjpvM2cyhiryk6t?=
 =?us-ascii?Q?0pKhEZs5F18ejGpomnwXuT+BmpcAEtTtENmSKZ6zHHoNE084zeSjkN0LNYCT?=
 =?us-ascii?Q?kBMW/7xZRONd5HYdpIe/uulLKFUlRy19gCn8mxSbzUBZ5o6GZfgI3PMvCMiR?=
 =?us-ascii?Q?PUBAT1uX+AI6jGRr+DNbA+SS9QnISQBiZn2U0PytikSN0ENK0OsEhOiKSmRQ?=
 =?us-ascii?Q?Mu+UHEFIhVrIUuxK/fgDCxDmLze9/7Py0lWQ4cr3GJlunFGv8p5WB9re819x?=
 =?us-ascii?Q?t43i3vkMku0AnfqhfluavIh7jPmtKhXRlQ2KpfSH9rpU6/LxlMVvTIeFfkdf?=
 =?us-ascii?Q?LXkVwV8o5YBrHBeEg9zcQc80q8/Me/jFT/16rDxE/bBaoGmj8sxYDEGzjqjm?=
 =?us-ascii?Q?3GODno99nzPWBR2A6nTfDlmdFHPXyMTYxUo24qSiGVCjkF8vNo3L77q0k+3U?=
 =?us-ascii?Q?FHPhCb0sYDCVVRUp8/e4ghapkU2my8A7NszvW4b3KpUxoeWyCVhBvXFLSId9?=
 =?us-ascii?Q?Jv2rst7LhQvB2UAO4U+sUDi5mdClAKLxxNbDeZxOe7e5oyWm6peJpoqohvpN?=
 =?us-ascii?Q?IYrZbds4bKtmD552LiBnHZCXVJUp5CbttJzKTflLD8rCsnrLuWMADj+lSkzy?=
 =?us-ascii?Q?rHkEhR3P2fkDUHrZf3u5b6i7YqhuJyXaCrElXur5Ya+sb+Z/j+CxvZvIfR/Z?=
 =?us-ascii?Q?pRXntq/bNbMiFXtvttAjC85hVPBfk+uoyC1WMZwDRSzjAF3cL7zzi5jtt3Lq?=
 =?us-ascii?Q?ac03Yh+QlN3U9rrds61sgtqGh2GIBUUiCnbMBMU56P9U4MmsNYZHRvNQk9rR?=
 =?us-ascii?Q?q6Sb9R78NtvYOHlnQp6b6PBrIOMWY8xOwZejSP87828GkfzsH+kFK1zwQQfR?=
 =?us-ascii?Q?TsX4PEjKhmTCs6XISXqFMojIXhd8DSgmbecEhw14?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c03f7c35-f11b-4491-9734-08dbd60f60f6
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 10:36:14.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WR6BWMCcaeDvqz2Q09TunQlzzaef9xkLFCeOiOE3dyjVnuqPB8hrcjE4L3QlVNF7W5aQUCndce8sCggSy5eh2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5407

On Thu, 26 Oct 2023 10:13:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 25, 2023 at 12:53:39PM -0700, Boqun Feng wrote:
> > In theory, `read_volatile` and `write_volatile` in Rust can have UB in
> > case of the data races [1]. However, kernel uses volatiles to implement
> > READ_ONCE() and WRITE_ONCE(), and expects races on these marked accesses
> > don't cause UB. And they are proven to have a lot of usages in kernel.
> > 
> > To close this gap, `read_once` and `write_once` are introduced, they
> > have the same semantics as `READ_ONCE` and `WRITE_ONCE` especially
> > regarding data races under the assumption that `read_volatile` and
> > `write_volatile` have the same behavior as a volatile pointer in C from
> > a compiler point of view.
> > 
> > Longer term solution is to work with Rust language side for a better way
> > to implement `read_once` and `write_once`. But so far, it should be good
> > enough.  
> 
> So the whole READ_ONCE()/WRITE_ONCE() thing does two things we care
> about (AFAIR):
> 
>  - single-copy-atomicy; this can also be achieved using the C11
>    __atomic_load_n(.memorder=__ATOMIC_RELAXED) /
>    __atomic_store_n(.memorder=__ATOMIC_RELAXED) thingies.
> 
>  - the ONCE thing; that is inhibits re-materialization, and here I'm not
>    sure C11 atomics help, they might since re-reading an atomic is
>    definitely dodgy -- after all it could've changed.
> 
> Now, traditionally we've relied on the whole volatile thing simply
> because there was no C11, or our oldest compiler didn't do C11. But
> these days we actually *could*.
> 
> Now, obviously C11 has issues vs LKMM, but perhaps the load/store
> semantics are near enough to be useful.  (IIRC this also came up in the
> *very* long x86/percpu thread)
> 
> So is there any distinction between the volatile load/store and the C11
> atomic load/store that we care about and could not Rust use the atomic
> load/store to avoid their UB ?

There's two reasons that we are using volatile read/write as opposed to
relaxed atomic:
* Rust lacks volatile atomics at the moment. Non-volatile atomics are
  not sufficient because the compiler is allowed (although they
  currently don't) optimise atomics. If you have two adjacent relaxed
  loads, they could be merged into one.
* Atomics only works for integer types determined by the platform. On
  some 32-bit platforms you wouldn't be able to use 64-bit atomics at
  all, and on x86 you get less optimal sequence since volatile load is
  permitted to tear while atomic load needs to use LOCK CMPXCHG8B.
* Atomics doesn't work for complex structs. Although I am not quite sure
  of the value of supporting it.


