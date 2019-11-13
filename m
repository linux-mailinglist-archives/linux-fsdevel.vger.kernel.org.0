Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152D9FBA11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 21:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKMUkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 15:40:22 -0500
Received: from smtpoutz22.laposte.net ([194.117.213.97]:42081 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726270AbfKMUkV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:40:21 -0500
X-Greylist: delayed 1311 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 15:40:19 EST
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout010 (Postfix) with ESMTP id D4D654B0817
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 21:18:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1573676306; bh=SroHNBwy4onOK+eJMeJyZO/vrstwXvYfrcOD+IJg7+Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mJyJM8mmkYHBFg6tOJFYTpaFi+S8XBStuIKzRZKeIa9/CIiJKWMntuANRj98Up18r
         i/LlEJrwyszje6pHAJRAGBXf1nyb/s3V2kNGam+C59/aeffkPbgUAoWqNhcZYK9kn8
         PZ2dublz0m7NtohTiA7NY8W3jTS2zqLslTCrZWh9dQ9Iasz8IkrabG3/3o5iaKzWAH
         PThxRyZU3QHtV4QEwoFv9It61TsUWf8fZZhrNk3Lylx3xynsyZzn/OFArF2vzMlids
         xPENnin1EoRTlRh6XmXbhh7UJy93vme3loJE97C491beCX5xbNrVSqh9V/7G/NIQmf
         cUpXINfy5r6qw==
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout010 (Postfix) with ESMTP id C50754B0851
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 21:18:26 +0100 (CET)
Received: from lpn-prd-vrin002 (lpn-prd-vrin002.prosodie [10.128.63.3])
        by lpn-prd-vrout010 (Postfix) with ESMTP id BE67E4B0804
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 21:18:26 +0100 (CET)
Received: from lpn-prd-vrin002 (localhost [127.0.0.1])
        by lpn-prd-vrin002 (Postfix) with ESMTP id A273E5E8761
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 21:18:26 +0100 (CET)
Received: from [192.168.43.153] (unknown [37.165.60.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by lpn-prd-vrin002 (Postfix) with ESMTPSA id E75F85E8710;
        Wed, 13 Nov 2019 21:18:24 +0100 (CET)
Subject: Re: [PATCH][RFC] ecryptfs_lookup_interpose(): lower_dentry->d_inode
 is not stable
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, wugyuan@cn.ibm.com,
        Jeff Layton <jlayton@kernel.org>,
        Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ecryptfs@vger.kernel.org
References: <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk>
 <20191102172229.GT20975@paulmck-ThinkPad-P72>
 <20191102180842.GN26530@ZenIV.linux.org.uk>
 <20191103163524.GO26530@ZenIV.linux.org.uk>
 <20191103182058.GQ26530@ZenIV.linux.org.uk>
 <20191103185133.GR26530@ZenIV.linux.org.uk>
 <CAOQ4uxiHH=e=Y5Xb3bkv+USxE0AftHiP935GGQEKkv54E17oDA@mail.gmail.com>
 <20191113125216.GF26530@ZenIV.linux.org.uk>
From:   Jean-Louis Biasini <jl.biasini@laposte.net>
Message-ID: <073aec80-353a-1568-8f4b-4d9330c0d5b4@laposte.net>
Date:   Wed, 13 Nov 2019 21:18:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113125216.GF26530@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-VR-FullState: 0
X-VR-Score: -100
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedufedrudefuddgudeflecutefuodetggdotefrodftvfcurfhr
X-VR-Cause-2: ohhfihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghn
X-VR-Cause-3: thhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtqhertddtfeejnecuhfhrohhm
X-VR-Cause-4: peflvggrnhdqnfhouhhishcuuehirghsihhnihcuoehjlhdrsghirghsihhniheslhgrphhoshhtvgdr
X-VR-Cause-5: nhgvtheqnecukfhppeefjedrudeihedriedtrddufeefnecurfgrrhgrmhepmhhouggvpehsmhhtphho
X-VR-Cause-6: uhhtpdhinhgvthepfeejrdduieehrdeitddrudeffedphhgvlhhopegludelvddrudeikedrgeefrddu
X-VR-Cause-7: heefngdpmhgrihhlfhhrohhmpehjlhdrsghirghsihhniheslhgrphhoshhtvgdrnhgvthdprhgtphht
X-VR-Cause-8: thhopegvtghrhihpthhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgr
X-VR-Cause-9: lhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhs
X-VR-Cause-10: vgdrtgiipdhrtghpthhtohephhhsihgrnhhgkhgrohesrgholhdrtghomhdprhgtphhtthhopehjlhgr
X-VR-Cause-11: hihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifuhhghihurghnsegtnhdrihgsmhdrtgho
X-VR-Cause-12: mhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
X-VR-Cause-13: phhtthhopehrihhtvghshhhhsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheplhhinhhugidq
X-VR-Cause-14: fhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhirhejfehilhes
X-VR-Cause-15: ghhmrghilhdrtghomhdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-VR-Cause-16: necuvehluhhsthgvrhfuihiivgeptd
X-VR-AvState: No
X-VR-State: 0
X-VR-State: 0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please can you UNSUBSCRIBE me from this list?

thx

Le 13/11/2019 =C3=A0 13:52, Al Viro a =C3=A9crit=C2=A0:
> On Wed, Nov 13, 2019 at 09:01:36AM +0200, Amir Goldstein wrote:
>>> -       if (d_really_is_negative(lower_dentry)) {
>>> +       /*
>>> +        * negative dentry can go positive under us here - its parent=
 is not
>>> +        * locked.  That's OK and that could happen just as we return=
 from
>>> +        * ecryptfs_lookup() anyway.  Just need to be careful and fet=
ch
>>> +        * ->d_inode only once - it's not stable here.
>>> +        */
>>> +       lower_inode =3D READ_ONCE(lower_dentry->d_inode);
>>> +
>>> +       if (!lower_inode) {
>>>                 /* We want to add because we couldn't find in lower *=
/
>>>                 d_add(dentry, NULL);
>>>                 return NULL;
>> Sigh!
>>
>> Open coding a human readable macro to solve a subtle lookup race.
>> That doesn't sound like a scalable solution.
>> I have a feeling this is not the last patch we will be seeing along
>> those lines.
>>
>> Seeing that developers already confused about when they should use
>> d_really_is_negative() over d_is_negative() [1] and we probably
>> don't want to add d_really_really_is_negative(), how about
>> applying that READ_ONCE into d_really_is_negative() and
>> re-purpose it as a macro to be used when races with lookup are
>> a concern?
> Would you care to explain what that "fix" would've achieved here,
> considering the fact that barriers are no-ops on UP and this is
> *NOT* an SMP race?
>
> And it's very much present on UP - we have
> 	fetch ->d_inode into local variable
> 	do blocking allocation
> 	check if ->d_inode is NULL now
> 	if it is not, use the value in local variable and expect it to be non-=
NULL
>
> That's not a case of missing barriers.  At all.  And no redefinition of=

> d_really_is_negative() is going to help - it can't retroactively affect=

> the value explicitly fetched into a local variable some time prior to
> that.
>
> There are other patches dealing with ->d_inode accesses, but they are
> generally not along the same lines.  The problem is rarely the same...
>

