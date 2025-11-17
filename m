Return-Path: <linux-fsdevel+bounces-68638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7AC62A78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 08:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93A9A349EEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 07:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068A33164AB;
	Mon, 17 Nov 2025 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajEn9Lum"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538CA1946DA;
	Mon, 17 Nov 2025 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763363193; cv=none; b=cSMN9nzGhfcuNJQuY+5f2aGC96LbOYL0Za7eDB1QDWeY+9niUluBZL3K4fkaY5cZyU1sTr5QOEHra9T+PW95ACPIgbvHKRDUTKxTj3aZaSLy2OddktyWCfQgEQKZicUXkMgeSvKGCwJRKLJnMMsX+j4KAdlcQGdu6+IcyF+sITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763363193; c=relaxed/simple;
	bh=KDZd9YTazDXwxaHEWm8apDVEeSXEzTkuHWdA30q5ZJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwrhTCyBYk2J5FBVnyWqPJEDtapVx98RPB55/ErPg0YneUpCIw47vFxEYrzvnA7a2RSuujKnX8SDfvHX+qeL9FqQrHGdRJ+QysCR5MoiddE886kIYRhOFIibv6ZdcMCyFQagQUkUGEXd4MpxV177++Fteg7hJjeKmiX+Zy3qk1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajEn9Lum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61424C4CEFB;
	Mon, 17 Nov 2025 07:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763363193;
	bh=KDZd9YTazDXwxaHEWm8apDVEeSXEzTkuHWdA30q5ZJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ajEn9LumigFa0k/MwaUalDCto9I/GU9myHvWejQEoX/l4a5N70RlXaG4RM8zdYQ5V
	 q5AlLAiLHNyw8Auc2iXYWyjirLMUunXwVIJRBBTSm0CsBXfuSu+xp1aeJvKRvQOeP5
	 IKKHSlAPe9WWC46RAq6JRoE5JZyQo7+xG0bXflZgM0Vh+hwzedx+BQgFK7ZKX1Y8mW
	 MqbF7TvBfY0nFt0925Qvz0X/J+9PSYlxmYZlqngxcu/xVebBja/rs6K5Vnqat89cNL
	 a0nVh6f8/YD5O81vU7tSUxSptEbbzIYEPaX4S8SbDgBkl70ZW1Da/53BDrTYOLa7hN
	 kFR5h3B1TFZxg==
Message-ID: <af101dba-b02f-4863-a893-789fa08124d0@kernel.org>
Date: Mon, 17 Nov 2025 08:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] uaccess: Add speculation barrier to
 copy_from_user_iter()
To: Thomas Gleixner <tglx@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Andre Almeida <andrealmeid@igalia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
 <598e9ec31716ce351f1456c81eee140477d4ecc4.1762427933.git.christophe.leroy@csgroup.eu>
 <87jyzr9tuo.ffs@tglx>
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Language: fr-FR
In-Reply-To: <87jyzr9tuo.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 15/11/2025 à 16:51, Thomas Gleixner a écrit :
> On Thu, Nov 06 2025 at 12:31, Christophe Leroy wrote:
>> The results of "access_ok()" can be mis-speculated.  The result is that
>> you can end speculatively:
>>
>> 	if (access_ok(from, size))
>> 		// Right here
> 
> This is actually the wrong patch ordering as the barrier is missing in
> the current code. So please add the missing barrier first.

Patch 1 is there because Linus was worried with the performance 
degradation brought by the barrier on x86, see [1]

[1] 
https://lore.kernel.org/all/CAHk-=wj4P6p1kBVW7aJbWAOGJZkB7fXFmwaXLieBRhjmvnWgvQ@mail.gmail.com/

If we change the order, it means we first degrade performance on x86 
with patch 1 then we fix that degradation with patch 2. It seems more 
natural to first ensure that the barrier won't degrade x86 then add the 
barrier.

An alternative is to squash both patches together, after all they touch 
the exact same part of the code.

Let me know what you prefer:
1/ Leave in that order to avoid intermediaite performance degradation on x86
2/ Change order
3/ Squash both patches together.

> 
> As a bonus the subject of the first patch makes actually sense
> then. Right now it does not because there is nothing to avoid :)
> 
> Also please use the same prefix for these two patches which touch the
> iter code.

Sure I'll do that.

> 
>> For the same reason as done in copy_from_user() by
>> commit 74e19ef0ff80 ("uaccess: Add speculation barrier to
>> copy_from_user()"), add a speculation barrier to copy_from_user_iter().
>>
>> See commit 74e19ef0ff80 ("uaccess: Add speculation barrier to
>> copy_from_user()") for more details.
> 
> No need to repeat that. Anyone with more than two braincells can look at
> that commit, which you mentioned already two lines above already.

Ok

Thanks
Christophe

