Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D785BF04A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 00:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiITWj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 18:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiITWjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:39:55 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2110.outbound.protection.outlook.com [40.107.10.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E47AE033;
        Tue, 20 Sep 2022 15:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiZ992iVBGf3ElfM8A2rONLupZYgvs+BXl+fm9cFEq6tbuIxmCCcledYbi/V8ofrn5bYi+mE/EA1uv0B61Wg62x6+tk7jm4lAvut2zVeAJAtl3W4kyQivdTrt8J5GfoQKATGsQc2rpT9wYMvQjp1hBbBHcUcsDt9uSWtc8b7lcjgjzlGYfdZLWcQhCXACsMrsa3y5Pmv8E3Gm6jwOhwWi3vXXz+S/fz23oH6Wct+qRl+aLr43EWNQVNr3XdbNNPkv8zr+NCdQDO/VZ4u6bH1nYhhy+wxPX93d1efFyHZSLm4DpFG7SdB3kW6Qi/QzGWd68bsjIaqZW0J1qXMfQLBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrob3Zyv3BbNx2crY5nTiL7EyT+uy5DH9XR9sJZoeYs=;
 b=Nz6dRggYk/7CQtfTWm9PPngf5dZjaLtZ9Yoi0QaxaNWKlpZsp0YSWSUEo77ebSSHT53Xq+KiLW8gjYnpPMqgjdT44bxxrd5A/N+cQ6xRSzjDYE3/tsswtLFJtPiOla6mZO4vHmyXTKiFhBbkUDxKVO8u/bLQzr0DbhEuzx8MoVjjCjNb9WEL+44pD0BXlPX+qsfPeaWnBzmqd96ECVvMI9qgsfOgiire3HH8hnHBGqeMG7pJGXZKM8TJTEUSEYlZX+pOezRH7AeocoEJMJNXG9pqzVnixOKMqNfA8c2umrInSyctdF1psZFypOoMmDfNF3Ns253zMVsCWUm82ex0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrob3Zyv3BbNx2crY5nTiL7EyT+uy5DH9XR9sJZoeYs=;
 b=FRHHtceyNGlVpl8efAhQcZyroy8LZ6bzCF5+LDnqMA/LQCCuyaE0RETxzT+88gw7uIumCfdSEfwWyZSyuR/DYh8uDBg8BYEYZ3LnTyPOgEVAEI00u0nXDmUmvMTHyIUldyjiJ9L1KH4yRZOyfrfLyCaAeoxyWla3jDDk8Ppplnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB7037.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Tue, 20 Sep
 2022 22:39:51 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::31ff:7dfd:5b99:2d1c]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::31ff:7dfd:5b99:2d1c%3]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 22:39:51 +0000
Date:   Tue, 20 Sep 2022 23:39:47 +0100
From:   Gary Guo <gary@garyguo.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>, ojeda@kernel.org,
        ark.email@gmail.com, bjorn3_gh@protonmail.com, bobo1239@web.de,
        bonifaido@gmail.com, boqun.feng@gmail.com, davidgow@google.com,
        dev@niklasmohrin.de, dsosnowski@dsosnowski.pl, foxhlchen@gmail.com,
        geofft@ldpreload.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, john.m.baublitz@gmail.com,
        leseulartichaut@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, me@kloenk.de, milan@mdaverde.com,
        mjmouse9999@gmail.com, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, thesven73@gmail.com,
        viktor@v-gar.de, Andreas Hindborg <andreas.hindborg@wdc.com>
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
Message-ID: <20220920233947.0000345c@garyguo.net>
In-Reply-To: <87a66uxcpc.fsf@email.froward.int.ebiederm.org>
References: <20220805154231.31257-13-ojeda@kernel.org>
        <Yu5Bex9zU6KJpcEm@yadro.com>
        <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
        <Yu6BXwtPZwYPIDT6@casper.infradead.org>
        <Yyh3kFUvt2aMh4nq@wedsonaf-dev>
        <CAHk-=wgaBaVaK2K=N05fwWSSLM6YJx=yLmP4f7j6d6o=nCAtdw@mail.gmail.com>
        <CAHk-=whTDbFZKB4KJ6=74hoLcerTm3JuN3PV8G6ktcz+Xm1qew@mail.gmail.com>
        <YyivY6WIl/ahZQqy@wedsonaf-dev>
        <CAHk-=whm5Ujw-yroDPZWRsHK76XxZWF1E9806jNOicVTcQC6jw@mail.gmail.com>
        <Yyjut3MHooCwzHRc@wedsonaf-dev>
        <CAHk-=wityPWw4YkHeMNU4iGanyiC3UwDRhbOHYCJrhB2paCGwA@mail.gmail.com>
        <CAFRnB2VPpLSMqQwFPEjZhde8+-c6LLms54QkMt+wZPjOTULESw@mail.gmail.com>
        <CAHk-=wiyD6KqZN8jFkMHPRPxrbyJEUDRP6+WaH9Q9hjDB5i1zg@mail.gmail.com>
        <CAHk-=wj6sDFk8ZXSEKUMj-J9zfrMSSO3jhBEaveVaJSUpr=O=w@mail.gmail.com>
        <87a66uxcpc.fsf@email.froward.int.ebiederm.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0565.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 439a08b4-7c43-43a0-db4a-08da9b5907d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: goQGTz2c/LRj+uxo1uxFDOe5C+qT4PgluWv7mfW7CXgPhLPssYfpoOdJZUvHVgeKOE0p48OMtuCvYh6Aw0hAB2gCnjpzqmW/8NDQFt0GOInmPvufKopeIRknn+7xBC8/wSZYulfCNPX+qwH5H5owSes3bTkW84kh0xZMD69rGwd/dTcYO3VwaFyUKSu1oi0GIttGi5ilRv9Yi8gFZZzoSj7aOnbGicZVtnaTBvEHwDEHzhamQ+lqMKKy7MFHiLwrhsaQKS4dDFKIDhHcvLRGM63SQ71qzq8xWLaS5F65tIEqimuqWGHtqfJsa6bx3UxXXo6LuP/ADWLL4IOI8xcKmvSbK9rOokbpmu7HauXHS4qiI6qQS7ZdgJNUpiCzWPg+hkjGImuznLOEqnJ7upk/iOZFiSeNJduuOWBZp0jAhM64MpgKY+p8ShBo9n6Gq/R7q/rY7BLNp+FqaxN3g5uUxgezzvOg61dTEhNqTKtnpd6YgLMQgdMt6JpedkC41HYKI8Qs75MLQaTfgqTARxBUeq219I4j0Sf7/vAKORbPXxECGQG6UN0h2EnEF6RlQ+bMv9lfeOnT5bywfSxOO2dwiEwHy7frqTSaD9r8BfZWyEVrndsX4moG3SkPZFiRhnTXQWehdw3v4wd/27UiYipuHo17xBEqspNt0qD0gykSPsv8+j6x0M2de5DrIdH0Hnhg5IpxlEQmbUvMsFylUORkulr1duz+qPilcwsK2uHn2XxzDOMvlcQlENjfBGm2A7VSr+H9FBFzd+2fQWrS+rh+Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(39830400003)(136003)(346002)(451199015)(7406005)(7416002)(5660300002)(83380400001)(6512007)(2906002)(6486002)(478600001)(6916009)(54906003)(316002)(38100700002)(1076003)(86362001)(186003)(41300700001)(6666004)(52116002)(6506007)(8936002)(2616005)(36756003)(53546011)(966005)(66946007)(8676002)(4326008)(66556008)(66476007)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XQFul/WX0N+GUDCliGhM/RMsJrwpirX2F8nNExOsTmXvP2sZ+y2mJ+DrkKSN?=
 =?us-ascii?Q?XA7mqeiPNe5AXD9+umqsRv/VVor2GisZwmqAZtNvGIs6Mjah/JHaI7LVPCk9?=
 =?us-ascii?Q?92peIpQ2Nhc43Z3Lh5YiXKetP2z/J/a6v5jWS78jt4inlLXEXSfmYt5WawZC?=
 =?us-ascii?Q?21uhkisZsmJnDX1BIkzMgtp6K8E31Ja0A89fKgn2cwromaqsQ0aQsARJ3cd0?=
 =?us-ascii?Q?4hfzyCwC+e6JvXHJcpha5Sv2g/aBNkPrM/WQURu5NZzqXyzkLMTDgTOnnr0a?=
 =?us-ascii?Q?ed3OyQsGww8RPKq/ftLCjWKlp09TgdxDbmSkIbabj/uoYZCECcITq4Zc2UAe?=
 =?us-ascii?Q?w6BA8QbqwZnrbl6JWbaAM/+S2ly69sKc0MVa2MOonOSKMkFMEGhLYs7NMO0o?=
 =?us-ascii?Q?z+szDaZ2aT5xhzMnTC3hQpKeqTKuVPVS15LRVlNIgcvQ0NApLUkmybtTSYP2?=
 =?us-ascii?Q?jqPIJROWYd3xpxIwKW/PF5LbXyqdtXztkq5E45ds3kx5EzHqdjHGhf/6Y2JZ?=
 =?us-ascii?Q?YaM438PmShf+b6wacp6pIyEqAs5lAEVqOyYTcl4WHF9KWiIBjpU37IktShu3?=
 =?us-ascii?Q?E7xJGuFJ12qkOut0kByVoGo8/e+bKFSKg4ereKzg8qpY6DuzM0Zrt1ZhlSVy?=
 =?us-ascii?Q?XZVSsa3BQCvNdsjcjF/q9vmDzXg8smSaX4MUqun8JD9kmtkZEjIsQWe7LxH6?=
 =?us-ascii?Q?MmDuYs2Xf0WiSWXn8/KR8DpOjzR9uk8Gq1g9c0835PbwoKoBHdEKDHu74fTp?=
 =?us-ascii?Q?xcY8lrN277NK9Xot1Pfr+bYin7i7w1k12zlqSt6s6JOkn6wnWKaXcxAN1kh4?=
 =?us-ascii?Q?ImLy88tRnT3c+lnlao+qNZpgYuDUwzYrFP0lBtHd32xu/U58nKSTrbgkOvUW?=
 =?us-ascii?Q?H/DRdMUIQ9HoPERE+mtjeiWvw/msmD+Wj6ejUJYv27U4mIO0nBRxLagVaXVX?=
 =?us-ascii?Q?BVPeWof8kaZv6uAHgKRSzgnhEycDaU8V7EBeX5aPvJT8+rqlF4ww170AeFvV?=
 =?us-ascii?Q?gPQZ1B3ZvSHvj/2SIXY0nN0Hq45qeIPWJ2fck89+tk4dx//A2UkiRAOA/I4f?=
 =?us-ascii?Q?vpH2Bo2B2jg8XoPaCOTNlhi/kNwtCry4HdkpfemFWgAV6MjomOulQngPELQB?=
 =?us-ascii?Q?wyo+saR7J3xMeejaTH7cjPppY/AnDmsP8M7w+VA1dNwaXylMrea9hDMQ1MGt?=
 =?us-ascii?Q?RLGgc7QtrSggqCsbolT+we5t8GIFUJc04/Al3vG52BBKoc4sTigVzmUIjSgZ?=
 =?us-ascii?Q?1lfTU3hZEQkFS9ug3Ah5Y+MSJKxG6EGFL1rSk4h4NZTa7vjEZMIReiWaJU/Y?=
 =?us-ascii?Q?h1yEgjewLeatjQWVVKoI3PBSImRM5QCgU768OgGzMhov1zU2TkizQnoy1jBp?=
 =?us-ascii?Q?V9JE/iG6KX7ukp0L4cxySy/+6xcy6Pn/Z74Ga918XXZvs11+OEcYXBveQ96P?=
 =?us-ascii?Q?Pmali0py1/xB8pGKdLYrrEuV3Pnv9srb/icXn5655yGD4mK2nLYOZaFpn2wS?=
 =?us-ascii?Q?FzNptHphBpaiBD+b5u49TjHj0nOrvl3fkS0zHW8VhePQCW2UikfFjmf52fW4?=
 =?us-ascii?Q?dtv+0L0lCdQvT2Qw/K2AvmtDwxL80gBeXUZ5Y0QNEjs+8AqGeCmp/SXYgylj?=
 =?us-ascii?Q?Q3fxnAPu5eIOIPXaWCS9n2l0GUDTvVabkWClrec17Sd+?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 439a08b4-7c43-43a0-db4a-08da9b5907d2
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 22:39:51.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HKe1Tw6T184OmFgNsLbJXaA5pF/hBNIJdIHmsup9gUvnX54ZqbIMXFV4sqora/lpqIgnybgBNmyLftbHEASqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Sep 2022 10:55:27 -0500
"Eric W. Biederman" <ebiederm@xmission.com> wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Mon, Sep 19, 2022 at 4:58 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:  
> >>
> >> This is not some kind of "a few special things".
> >>
> >> This is things like absolutely _anything_ that allocates memory, or
> >> takes a lock, or does a number of other things.  
> >
> > Examples of "number of other things" ends up being things like
> > "accessing user memory", which depending on what you are doing may
> > be very common too.
> >
> > And btw, it's not only about the (multiple kinds of) atomic regions.
> >
> > We have other context rules in the kernel too, like "does floating
> > point or vector unit calculations". Which you can actually do, but
> > only in a kernel_fpu_begin/kernel_fpu_end region.
> >
> > Now, the floating point thing is rare enough that it's probably fine
> > to just say "no floating point at all in Rust code".  It tends to be
> > very special code, so you'd write it in C or inline assembly,
> > because you're doing special things like using the vector unit for
> > crypto hashes using special CPU instructions.  
> 
> I just want to point out that there are ways of representing things
> like the context you are running in during compile time.  I won't
> argue they are necessarily practical, but there are ways and by
> exploring those ways some practical solutions may result.
> 
> Instead of saying:
> spin_lock(&lock);
> do_something();
> spin_unlock(&lock);
> 
> It is possible to say:
> with_spin_lock(&lock, do_something());
> 
> This can be taken a step farther and with_spin_lock can pass a
> ``token'' say a structure with no members that disappears at compile
> time that let's the code know it has the spinlock held.
> 
> In C I would do:
> struct have_spin_lock_x {
> 	// nothing
> };
> 
> do_something(struct have_spin_lock_x context_guarantee)
> {
> 	...;
> }
> 
> I think most of the special contexts in the kernel can be represented
> in a similar manner.  A special parameter that can be passed and will
> compile out.
> 
> I don't recall seeing anything like that tried in the kernel so I
> don't know if it makes sense or if it would get too wordy to live,
> but it is possible.  If passing a free context parameter is not too
> wordy it would catch silly errors, and would hopefully leave more
> mental space for developers to pay attention to the other details of
> the problems they are solving.
> 
> *Shrug*  I don't know if rust allows for free parameters like that and
> if it does I don't know if it would be cheap enough to live.

I believe this was mentioned by Wedson in one of his previous emails.
This pattern is quite common in Rust code. It looks like this:

	#[derive(Clone, Copy)]
	pub struct Token<'a>(PhantomData<&'a ()>);
	
	pub fn with_token<T>(f: impl for<'a> FnOnce(Token<'a>) -> T) ->
	T { f(Token(PhantomData))
	}

Any function that requires something can just take token by value, e.g.
with `token: Token<'_>`. Since Token is a zero-sized type (ZST), this
parameter will be omitted during code generation, so it won't affect
the ABI and this has no runtime cost.

Example on godbolt: https://godbolt.org/z/9n954cG4d, showing that the
token is actually all optimised out.

It should be noted however, atomic context is not something that a
token can represent. You can only use tokens to restrict what you *can*
do, but not what you *can't* do. There is no negative reasoning with
tokens, you can't create a function that can only be called when you
don't have token.

You can use tokens to represent non-atomic contexts, but that'll be
really painful because this requires carrying a token in almost all
functions. This kind of API also works well for FPU contexts.

Best,
Gary
