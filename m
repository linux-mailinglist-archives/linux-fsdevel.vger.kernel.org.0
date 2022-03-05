Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F84CE57C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 16:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiCEPOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 10:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiCEPOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 10:14:50 -0500
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE72B1D0D73;
        Sat,  5 Mar 2022 07:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646493155;
        bh=m1wvyXcdmqw6SUGsb6WV3jmsFgfj7oNi36tuWjXyAkM=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=DJN6ASTmsXnmy9508UVvVAWneNbqlhxUUhC1cGGWcsJO5YCylURfI/AZcQX7xZoEf
         o4V35s3iNdNGuzBK3jl9KBVQlVSgVfu/aPx2k3Z0CNUIO0IDHtJcpSo9fqJKFFdtyE
         UtOJqK47iuFs7XGmvRmJTnFtEvI8SVNE9k06QOt8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from smtpclient.apple ([98.128.181.196]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryTF-1nwDfK1uOD-00nwc9; Sat, 05
 Mar 2022 16:12:35 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: Report 2 in ext4 and journal based on v5.17-rc1
From:   =?utf-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
In-Reply-To: <20220305145534.GB31268@X58A-UD3R>
Date:   Sat, 5 Mar 2022 16:12:27 +0100
Cc:     Theodore Ts'o <tytso@mit.edu>, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, torvalds@linux-foundation.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jack@suse.com,
        jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
        djwong@kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <56315101-B3A5-4596-947E-5D34A5FFBB37@gmx.de>
References: <YiAow5gi21zwUT54@mit.edu>
 <1646285013-3934-1-git-send-email-byungchul.park@lge.com>
 <YiDSabde88HJ/aTt@mit.edu> <20220304032002.GD6112@X58A-UD3R>
 <YiLbs9rszWXpHm/P@mit.edu> <20220305145534.GB31268@X58A-UD3R>
To:     Byungchul Park <byungchul.park@lge.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Provags-ID: V03:K1:whvk+lhsJ/zxK8CBSH/p6zkUgWk2DoodFfcAiSCDJJDa+Hp52O6
 Nfbhzzi+ktuZGYLtwoW9qfNJSraLEANrCWwT6xWYdnQrtUG7isGY5jyxYDHq4HWVXkcNwht
 L9exf7duZUup6Aj10JBs0SWk28hmicYpdhO/lD+yWMXlJTEBEhIt2rcl05AL/SZCvLbMreY
 BxuBvW4ogWm5Bxp58qVkg==
X-UI-Out-Filterresults: junk:10;V03:K0:zweSzRTuMLc=:1xDoFGJXHax66F8wkqbjhSe+
 jrZLpaWfX7RdsGmf8c0wJqGXUOnP34+DW7J0BkFSDsySKSvgdL1OmujM86iapxROKsjWBK2at
 AaC7YJVZCyA69Hv3P27MHCgbSK2zzZ4KK2Oe6GrYEmlwpy2FVbSCC/7xeun6zHlkVjuvIiddh
 D4/pwsRjcVcrDUVoJICcsRBTchjbZLhIzt6oU67TpQkTiAEHOXsRgD1jE7K/aARIlal/l2DVl
 xPrJgqJCdEeMD3K9HvWDaPdYPjGsLT+GqqhXDVTE/ZcBhH7gKjsxJ1+6Mx4r/zZIKC+9botr2
 IqYgSgXq5eRA+8vyUQh0uKDBl4f8f86J1pLHhUfqTVAzMUY39gYDS3LotRNJ3MFJABZf/lfjU
 0cyRUgOdsJ6qqJcIKXfabLzgCot3capLHxR2Y+QRnznXqMxMkuBWP/rfXMs4MV3IkGURCPEoR
 wjCQhSrxHEGzJg0IgcnYcPBWmaLWaoVy2k4UegQ/5MPQzywDfjBbz7bByArBN6HJXmBIwBB9y
 Pnh842Sj+JQ973UNMWaTtagNhqHDCFCUaii/U8GlWHeF0T3tZnXCKT9K+bTK3JEC9wI0mr+N7
 5c68iMxdADA2W/VhYX6D4ze1a7YULWtNZNMNy3FDWaZyegNOruAYBPRGqiC1ncvx1LUISdbO/
 8cW5Vg63lSiNWbL7GiPnEdRbk3vOksWKOVO4yhLonUE4f42S4PeEXN8IGr/zcBfEmPt4mImVd
 VWm9zpdNEo757DatvTW65sCdc6d9d4k4HWmXtEImH0pfIKwvELQRKV5KqWKK8AzF0jSCe08yN
 Pi333IVY6GV+LnI6SAxcsz0pac55X8Thf6xgpZKv08yi9/E/8ZPSGr44SrhTn4LnoZTrCkjA9
 +rdNMQQcevr3RF/Clrov3MYdmjcrJdJgY1A5A4/XUa98fnknpSHrjwxR3ZEUQ+U9XNqdW0pqm
 GDTzGpUb3Ha6onL+4oSq75jck6wezug8OqsouYMtWySjuX8G+mKJRihqyBiSNzVlSvOoXp8g/
 2H4Eb86TLwPlahcEuRGUNI1dWpXZnpZHfWWaVTjpDLy7wPmUwWJY9U6bdxiBhka347RRMDMyY
 OpNYdXIQhCSfFWczlu9AXKQxyo5fAi+eho0to5QLeVlsFKfKAqCn+yg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
Sorry to butt in as an outsider, but this seems like a shockingly =
disrespectful discussion for such a wide CC list.
I don't want to make rules how you discuss things (I very rarely =
contribute), and I see the value in a frank discussion, but maybe you =
could continue with a reduced CC list?
I find it unlikely that I am the only one who could do without this.

Best regards,
Reimar D=C3=B6ffinger

> On 5 Mar 2022, at 15:55, Byungchul Park <byungchul.park@lge.com> =
wrote:
>=20
> On Fri, Mar 04, 2022 at 10:40:35PM -0500, Theodore Ts'o wrote:
>> On Fri, Mar 04, 2022 at 12:20:02PM +0900, Byungchul Park wrote:
>>>=20
>>> I found a point that the two wait channels don't lead a deadlock in
>>> some cases thanks to Jan Kara. I will fix it so that Dept won't
>>> complain it.
>>=20
>> I sent my last (admittedly cranky) message before you sent this.  I'm
>> glad you finally understood Jan's explanation.  I was trying to tell
>=20
> Not finally. I've understood him whenever he tried to tell me =
something.
>=20
>> you the same thing, but apparently I failed to communicate in a
>=20
> I don't think so. Your point and Jan's point are different. All he has
> said make sense. But yours does not.
>=20
>> sufficiently clear manner.  In any case, what Jan described is a
>> fundamental part of how wait queues work, and I'm kind of amazed that
>> you were able to implement DEPT without understanding it.  (But maybe
>=20
> Of course, it was possible because all that Dept has to know for basic
> work is wait and event. The subtle things like what Jan told me help
> Dept be better.
>=20
>> that is why some of the DEPT reports were completely incomprehensible
>=20
> It's because you are blinded to blame at it without understanding how
> Dept works at all. I will fix those that must be fixed. Don't worry.
>=20
>> to me; I couldn't interpret why in the world DEPT was saying there =
was
>> a problem.)
>=20
> I can tell you if you really want to understand why. But I can't if =
you
> are like this.
>=20
>> In any case, the thing I would ask is a little humility.  We =
regularly
>> use lockdep, and we run a huge number of stress tests, throughout =
each
>> development cycle.
>=20
> Sure.
>=20
>> So if DEPT is issuing lots of reports about apparently circular
>> dependencies, please try to be open to the thought that the fault is
>=20
> No one was convinced that Dept doesn't have a fault. I think your
> worries are too much.
>=20
>> in DEPT, and don't try to argue with maintainers that their code MUST
>> be buggy --- but since you don't understand our code, and DEPT must =
be
>=20
> No one argued that their code must be buggy, either. So I don't think
> you have to worry about what's never happened.
>=20
>> theoretically perfect, that it is up to the Maintainers to prove to
>> you that their code is correct.
>>=20
>> I am going to gently suggest that it is at least as likely, if not
>> more likely, that the failure is in DEPT or your understanding of =
what
>=20
> No doubt. I already think so. But it doesn't mean that I have to keep
> quiet without discussing to imporve Dept. I will keep improving Dept =
in
> a reasonable way.
>=20
>> how kernel wait channels and locking works.  After all, why would it
>> be that we haven't found these problems via our other QA practices?
>=20
> Let's talk more once you understand how Dept works at least 10%. Or I
> think we cannot talk in a productive way.
>=20

