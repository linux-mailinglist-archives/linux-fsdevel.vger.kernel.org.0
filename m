Return-Path: <linux-fsdevel+bounces-19725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 986468C9570
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 19:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284811F21AF9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FCF4E1CE;
	Sun, 19 May 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="q1zu7ii7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1BB4C627
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716138223; cv=none; b=kPR1cEu8gGOxuXT1PzK7qJAtH+nHuHcbVn4Q8CTpwhW/ok1y5EnY45j2mbzzr6jzwCXsy/hgvZlhlMDv6ZE4dSkE2fzhT1+o1YDpzdGUzpoLC52hXSRMy4KXVGzfvdZIQeXmjpslFHZTUDOcgIxjNmceDQfCb9QfkSEXUzCK4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716138223; c=relaxed/simple;
	bh=IIIQWDyY02fuOATschViKWXO1zp50Kj/DmwFCAdFY4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAkTymzGwF2hEM6QNm3UiGlgNlbi1/kQ7yrJtyB7o8B8QSxeZQhH5MGBFudEFvmUPKX6qHrn/Pf2b1ymLyn7rj7wZFQjQcVKzksgJL+NM+Ld6fvogG3ziabzYxt+pEqPoQjPsRfekIM5id57q24K20my0oJPeEaaHdAOVO75EgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=q1zu7ii7; arc=none smtp.client-ip=66.163.184.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1716138215; bh=9Tmk45Zq8sa/lWYfQzgYaSCGFJCTICz+mmDIEDX1RwY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=q1zu7ii7xexouho3rPi7m6sr8WWMn5yws2S4CjqceC6HfsZY//WtNBtTBMJ/oyuVHvZhEHGJrEHwtQ7aO7/PuW6OWya6gUnYD5/qUZjdaS/2afbbVjDKDHDUU52I9xBss/FZvWncahWMgo1rdarVBJ4u9PEHue2gq4vv+tukfigTn9rSqUgBIwZIfdPG+PHHKyhdjFnCeeI141TPH1hxSKcZ0vAeunmmhPBVka7YElbfs2P/Qnwrr24WG1op+kqpVPqu6Qmb3c9Lidl9WX+K4+hJithuEqOedx6Hi+RDgyLrAO/l/GSR9OpDCIgWkg9HhwRhekN4Gatm1hAftznXFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1716138215; bh=bBL4r1YJviNTsDpboPEJVzbvQsf1X4dHWx+2zc84AtK=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HNI2tYoWssy7QdE+h8gjIAL6/QB5KtQ71K6Tj8xVDfvgLslTo+tZjquur9Ul6He/sopw/NvHHwqE/+STfnrLbk8GXpwqfPwwI4JcJPZ3Kz5r7PcZozsHhDc/snF5vrp8h9iQArH7fg9V+6jW0ES95XIpyXOE8mbD4ukkC1ryK30n6enoFtCiAEyH5135ye/URksp2gA0IyDqkxKmlrgwxzJGDm6DfTaRdkAesSIpPN8sfJ7LTy8/4pPEw3N0oV+3lNyZbkCE0VenYeQohXI2hvf5v0jR4Hr9KglLZFPkz6MZKikfpnqFMDie0xusek2mo/9ldr8tnAwql6dgFAAR/g==
X-YMail-OSG: VSKph8IVM1lbJ926igj_led9qPaxbsVrBMugFBvdZCM.41CC1senLRpkImrk0zF
 e3UJkwbfeWZ7mhSfT0CQqJU8_rFGbeyOmaA9YrQhtznipSSlfm0AWtaCncKlJZf8dTl1hgG8JsNr
 wgRVIJinVg7RjWluEY0nT_GUysybEbEIWvC1A1bD8ajGMN41PWE2h2nm6U_mqA2VPVLjLAK9qsID
 ctW.rWZoEaXl_ZWhMlDJW7cw5mD37PWuKBWIAr2Yjg6UoR2iIfg2zFaPpbmWax_a_wyZHEJcqalF
 .Madiyq30Tj.WT5Xk.guGsB6xdKPtiVNuyivAD9AthDbWCZTuYJ.z4EAtFHtFJ8jOVxREupY.OIl
 PLFef1K0POq.kPJgN7qNdRxKoW3m1TZscQnZmznJrY1FxcKF1xBQDTPso7rEA.wImAP4t82451Bl
 jTJ68rr.VI_qVlJNH_HCZEywIRpXfUViJ5LPIfBEXbs9xZgtFd_m40HqEnKvR0xb4oGj7g01Z.IS
 8AeQ199rTtBrk6O0fDfR6Axnt8dQFxH2gzi7KCgibbpQuQYzLIgCbQZTVRRmeD1umbFRiKk8KCQ5
 MuAFWvJ44mmy43_5brELLC0L7_JX0ITaUvTFBhBP4GABcbuFAcbwrjkGVleGwCg0tLB8wF.71LPL
 vXJnrqDgdrO_5pJGfxa2249zgGJXPY6P_WrC85eTvAbsM2vmrsNOuf7kJ7I_8De4wzhfNGi1quD7
 TdePMeP7qJgosI1xsCeYs1pG1WJ56T2TbQ5d4wp5fcxeG5rVX7VHXdA_V39olwXCrD3HY5_IKzz1
 K8zHK_TS8nv9yCoBmdlKIYduWuTnI4sDYmwk9cEnbUupm392o8.5Ma1fqO5WK5ZWmWYgq65DW9bl
 9kDDtdXgToJ1o9nJ_PqelRmHq1bgdmtc.wyo.77IjMCR8BrxStfYQMSbzNwUUbebSN_9Lrx_Y52C
 sBh.D.GB8js5Nld_wl.lQJPg92Xh23K3C1SaMT9EJYOVW_nfidD2rzAspkv9HGx0E4MCkFZtxtqz
 uclMEUOGdPZVkcg03wJzVKZ0xgdnCZx3s_ubrulNVGHA57G4bTGKfBdVPl.zJvui8jI7W8GsXdKd
 jrWUmPjqmCqW4cnzAPUpytPMLgDniD7ymXuwJwheH5rbT9BZsTgegspZnilSoHdBAsga3VuPxu5O
 4Z37kfXGzsqEE.s3ZUtLX8BaHdTiaxJ7UDGOG386ZFNnxxuQ18LSOLmp1IZ9g94bvtSTscb81c3b
 .Z15hCRaisXW2O6oUsOrv2_uMvb2PSb6w.RrHF8AqHFgzzG1e7MPhR69sOkFVZDYzJajYfpSv4qW
 l.YzJ7KAj.CsVKM_BGwPs5sgh58z0MPlFKkfxBFYkAEyJPZaNLQm4X7jV65.KCHwTBq_A3BWvFwt
 r7VEn_RlVtYyIxcb3Q35LL6V3cKuPQvZzF.gGu7SI5WSzKQbjjABPu8Z6o3683PpBZzo3T3CetsW
 wAlH3YGY6DedTaA4YOfI8FNa68gKMSeNR3wvLa.nLRowu7bR9z5AxLtxJALEx95_6RINcAa8zqxR
 7IrIUD8.HXtpVBc_lnMLbxLbcM1QdE3Bmo2IlsLFVVsOAa8lgoiI3D5AXutJ5BLISkS4BJDiPKrA
 ms3y_kgRg2IYhTRgROAmFbyu9a7LVIA9S_Yc43af0UGdSL_4e8.eSmearQApKJuIeYSggNBPG8jV
 TSNco8QbooUmQYjI1OhaxGYTOPBDAoX72kLr51faQyjQ9TC425QZ6YY_ZIQSTnn6iuUNoBkst6qc
 eTgVxoG84GIC9L_k1naQE.eBRZah1IxoOt53Ihz7u87.C7H3H8QlUiTh4RwR5mZjFkt4r_8wsb8a
 W.87EhxBfMciMLgWeEgPNpX8nxRgmB3221nRA3GSXK_j74YL5AtMBwO92Jk8OUQY3tXUfm8QyGbs
 X6hW6eaL7hHjFhlKcFFgMM_d6812OyqhcN0dw6qQHM0FoyXxrGCbLy1Z3o94XbpX4TA7NUFtYXuV
 5MBQZgRazuUbPbIAwyGN8WsMB611VXg_DSzhSjqt.1PtFO5_Kzc2XPWMDmMkqrU5D3C6xKPB1XwN
 G2Q.YpJnYWcrD4wSd9pMobIT.dLFYuyQPskyauV84vcV3Ha8ONL3jtk1jFkD6HCCFJUCccCuwQCL
 yRvAXkxXTFTDD5AWiqgQOFm7F6V1Ubpjb_5NW8HEdNF4o0rn3qQsxkrpQlNcb_BeRzurJsB3C2ur
 iJX_t4YMUETClZnL1LcNPjT1s9BfRcA1w22m2pFlFJe0X.dKjV99W5py.rFKbjb5D7wlng7uDE6A
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 052a17f7-6c89-4ae5-a1e9-4fdf598d91e8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sun, 19 May 2024 17:03:35 +0000
Received: by hermes--production-gq1-59c575df44-cc288 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a9b3cf1df92256c8fc12f4b75065caa2;
          Sun, 19 May 2024 17:03:31 +0000 (UTC)
Message-ID: <799f3963-1f24-47a1-9e19-8d0ad3a49e45@schaufler-ca.com>
Date: Sun, 19 May 2024 10:03:29 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
To: Serge Hallyn <serge@hallyn.com>
Cc: Jonathan Calmels <jcalmels@3xx0.net>, Jarkko Sakkinen
 <jarkko@kernel.org>, brauner@kernel.org, ebiederm@xmission.com,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Joel Granados <j.granados@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>,
 containers@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 keyrings@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>
 <D1BBFWKGIA94.JP53QNURY3J4@kernel.org>
 <D1BBI1LX2FMW.3MTQAHW0MA1IH@kernel.org>
 <D1BC3VWXKTNC.2DB9JIIDOFIOQ@kernel.org>
 <jvy3npdptyro3m2q2junvnokbq2fjlffljxeqitd55ff37cydc@b7mwtquys6im>
 <df3c9e5c-b0e7-4502-8c36-c5cb775152c0@schaufler-ca.com>
 <ZkidDlJwTrUXsYi9@serge-l-PF3DENS3>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <ZkidDlJwTrUXsYi9@serge-l-PF3DENS3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22356 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/18/2024 5:20 AM, Serge Hallyn wrote:
> On Fri, May 17, 2024 at 10:53:24AM -0700, Casey Schaufler wrote:
>> On 5/17/2024 4:42 AM, Jonathan Calmels wrote:
>>>>>> On Thu May 16, 2024 at 10:07 PM EEST, Casey Schaufler wrote:
>>>>>>> I suggest that adding a capability set for user namespaces is a bad idea:
>>>>>>> 	- It is in no way obvious what problem it solves
>>>>>>> 	- It is not obvious how it solves any problem
>>>>>>> 	- The capability mechanism has not been popular, and relying on a
>>>>>>> 	  community (e.g. container developers) to embrace it based on this
>>>>>>> 	  enhancement is a recipe for failure
>>>>>>> 	- Capabilities are already more complicated than modern developers
>>>>>>> 	  want to deal with. Adding another, special purpose set, is going
>>>>>>> 	  to make them even more difficult to use.
>>> Sorry if the commit wasn't clear enough.
>> While, as others have pointed out, the commit description left
>> much to be desired, that isn't the biggest problem with the change
>> you're proposing.
>>
>>>  Basically:
>>>
>>> - Today user namespaces grant full capabilities.
>> Of course they do. I have been following the use of capabilities
>> in Linux since before they were implemented. The uptake has been
>> disappointing in all use cases.
>>
>>>   This behavior is often abused to attack various kernel subsystems.
>> Yes. The problems of a single, all powerful root privilege scheme are
>> well documented.
>>
>>>   Only option
>> Hardly.
>>
>>>  is to disable them altogether which breaks a lot of
>>>   userspace stuff.
>> Updating userspace components to behave properly in a capabilities
>> environment has never been a popular activity, but is the right way
>> to address this issue. And before you start on the "no one can do that,
>> it's too hard", I'll point out that multiple UNIX systems supported
>> rootless, all capabilities based systems back in the day. 
>>
>>>   This goes against the least privilege principle.
>> If you're going to run userspace that *requires* privilege, you have
>> to have a way to *allow* privilege. If the userspace insists on a root
>> based privilege model, you're stuck supporting it. Regardless of your
>> principles.
> Casey,
>
> I might be wrong, but I think you're misreading this patchset.  It is not
> about limiting capabilities in the init user ns at all.  It's about limiting
> the capabilities which a process in a child userns can get.

I do understand that. My objection is not to the intent, but to the approach.
Adding a capability set to the general mechanism in support of a limited, specific
use case seems wrong to me. I would rather see a mechanism in userns to limit
the capabilities in a user namespace than a mechanism in capabilities that is
specific to user namespaces.

> Any unprivileged task can create a new userns, and get a process with
> all capabilities in that namespace.  Always.  User namespaces were a
> great success in that we can do this without any resulting privilege
> against host owned resources.  The unaddressed issue is the expanded
> kernel code surface area.

An option to clone() then, to limit the capabilities available?
I honestly can't recall if that has been suggested elsewhere, and
apologize if it's already been dismissed as a stoopid idea.

>
> You say, above, (quoting out of place here)
>
>> Updating userspace components to behave properly in a capabilities
>> environment has never been a popular activity, but is the right way
>> to address this issue. And before you start on the "no one can do that,
>> it's too hard", I'll point out that multiple UNIX systems supported
> He's not saying no one can do that.  He's saying, correctly, that the
> kernel currently offers no way for userspace to do this limiting.  His
> patchset offers two ways: one system wide capability mask (which applies
> only to non-initial user namespaces) and on per-process inherited one
> which - yay - userspace can use to limit what its children will be
> able to get if they unshare a user namespace.
>
>>> - It adds a new capability set.
>> Which is a really, really bad idea. The equation for calculating effective
>> privilege is already more complicated than userspace developers are generally
>> willing to put up with.
> This is somewhat true, but I think the semantics of what is proposed here are
> about as straightforward as you could hope for, and you can basically reason
> about them completely independently of the other sets.  Only when reasoning
> about the correctness of this code do you need to consider the other sets.  Not
> when administering a system.
>
> If you want root in a child user namespace to not have CAP_MAC_ADMIN, you drop
> it from your pU.  Simple as that.
>
>>>   This set dictates what capabilities are granted in namespaces (instead
>>>   of always getting full caps).
>> I would not expect container developers to be eager to learn how to use
>> this facility.
> I'm a container developer, and I'm excited about it :)

OK, well, I'm wrong. It's happened before and will happen again.

>
>>>   This brings namespaces in line with the rest of the system, user
>>>   namespaces are no more "special".
>> I'm sorry, but this makes no sense to me whatsoever. You want to introduce
>> a capability set explicitly for namespaces in order to make them less
>> special?
> Yes, exactly.

Hmm. I can't say I buy that. It makes a whole lot more sense to me to
change userns than to change capabilities.

>
>> Maybe I'm just old and cranky.
> That's fine.
>
>>>   They now work the same way as say a transition to root does with
>>>   inheritable caps.
>> That needs some explanation.
>>
>>> - This isn't intended to be used by end users per se (although they could).
>>>   This would be used at the same places where existing capabalities are
>>>   used today (e.g. init system, pam, container runtime, browser
>>>   sandbox), or by system administrators.
>> I understand that. It is for containers. Containers are not kernel entities.
> User namespaces are.
>
> This patch set provides userspace a way of limiting the kernel code exposed
> to untrusted children, which currently does not exist.

Yes, I understand. I would rather see a change to userns in support of a userns
specific need than a change to capabilities for a userns specific need.

>>> To give you some ideas of things you could do:
>>>
>>> # E.g. prevent alice from getting CAP_NET_ADMIN in user namespaces under SSH
>>> echo "auth optional pam_cap.so" >> /etc/pam.d/sshd
>>> echo "!cap_net_admin alice" >> /etc/security/capability.conf.
>>>
>>> # E.g. prevent any Docker container from ever getting CAP_DAC_OVERRIDE
>>> systemd-run -p CapabilityBoundingSet=~CAP_DAC_OVERRIDE \
>>>             -p SecureBits=userns-strict-caps \
>>>             /usr/bin/dockerd
>>>
>>> # E.g. kernel could be vulnerable to CAP_SYS_RAWIO exploits
>>> # Prevent users from ever gaining it
>>> sysctl -w cap_bound_userns_mask=0x1fffffdffff

