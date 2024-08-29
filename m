Return-Path: <linux-fsdevel+bounces-27763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46E9639E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 07:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD5D1C21943
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B5E148FF0;
	Thu, 29 Aug 2024 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tE4nHiaV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF19EAD5;
	Thu, 29 Aug 2024 05:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724909607; cv=none; b=WDk7yJmhs6W5GTxFXf6KSpzg2m8r4q3242sluYZGfYT8ByksX7O+w/dI8dA147a6hbwSdPMQpxRGv9UWyvKR4+UxFlM3ptZAR9mBW5pZt0K0VUNJdTRV67A4RcwjSS/+uLEYuEOR04c2BRG6LBq7t/PdL+oXY/ZZuyCo8V7AeUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724909607; c=relaxed/simple;
	bh=tGOvwmXOs76XhqKtvRUyCxm5Pa342IrbVlP8rxGktWA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rUkU0ki+V+edNd+RzuWbOnA1rYlPRUKubWBRtZQqu9vHtjZ9+UsSlX7fjlvYFoPG+mgOVnMM7nVEYFoTVn7GhC7318IzAp45j7t3mByVUj8behs3kVutrJhXsYaONOyERQDRJdWLmrAhmLl5vtTYlfTCjKVg3MZHwWgS0NGjmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tE4nHiaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7007FC4CEC1;
	Thu, 29 Aug 2024 05:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724909606;
	bh=tGOvwmXOs76XhqKtvRUyCxm5Pa342IrbVlP8rxGktWA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=tE4nHiaVZ2oLjNi0Rwfz8L79JoWj5SM87XU55S/OKhRgfte7lOJ80D1T91wtry5Qe
	 XtB3qvIj3vWYkk8X779kTZPIKHm3NYz6c42ftvsclrjJwBT3JG+LxxYf1wMHti7PcV
	 a4m3Y9pXNwOCYAVNaw9nOHDl4hmXI0s25C9WfLBf3vfkqVD0mGrACq4O5nFf3Yd4sD
	 zSgys6pmRcnOBlaNndeXW+G5PBHZj8wNE4VUzL9Jsx8z4OHgtq+D8JQvS+edsGtKIE
	 8bhDWuGQvQBbWCCNqI6at8SBZ2RO/7bcVhjaCoNBTSQHGdwTUx/F6pblKuMwc0sIx5
	 HGA5GrqnH/m4Q==
Date: Wed, 28 Aug 2024 22:33:23 -0700
From: Kees Cook <kees@kernel.org>
To: Xingyu Li <xli399@ucr.edu>
CC: mcgrof@kernel.org, j.granados@samsung.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>,
 "Paul E. McKenney" <paulmck@kernel.org>, Waiman Long <longman@redhat.com>,
 Sven Eckelmann <sven@narfation.org>, Thomas Gleixner <tglx@linutronix.de>,
 anna-maria@linutronix.de, frederic@kernel.org, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Tejun Heo <tj@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: BUG: WARNING in retire_sysctl_set
User-Agent: K-9 Mail for Android
In-Reply-To: <CALAgD-6CptEMjtkwEfSZyzPMwhbJ_965cCSb5B9pRcgxjD_Zkg@mail.gmail.com>
References: <CALAgD-4uup-u-7rVLpFqKWqeVVVnf5-88vqHOKD-TnGeYmHbQw@mail.gmail.com> <202408281812.3F765DF@keescook> <CALAgD-6CptEMjtkwEfSZyzPMwhbJ_965cCSb5B9pRcgxjD_Zkg@mail.gmail.com>
Message-ID: <BA3EA925-5E5E-4791-B820-83A238A2E458@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 28, 2024 10:02:00 PM PDT, Xingyu Li <xli399@ucr=2Eedu> wrote:
>In fact, the bugs that I report are fuzzed by the syzkaller templates
>that we generated, but not those from the syzkaller official
>templates=2E We want to find bugs that do not have the corresponding
>official syzkaller template=2E
>I also checked to make sure that the bugs I reported did not occur on syz=
bot=2E

That's excellent that you've developed better templates! Can you submit th=
ese to syzkaller upstream? Then the automated fuzzing CI dashboard will ben=
efit (and save you the work of running and reporting the new finds)=2E

-Kees

--=20
Kees Cook

