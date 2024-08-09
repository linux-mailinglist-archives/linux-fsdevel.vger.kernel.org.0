Return-Path: <linux-fsdevel+bounces-25534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4858B94D256
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6581C20873
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948B419754A;
	Fri,  9 Aug 2024 14:40:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE7B156676;
	Fri,  9 Aug 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214442; cv=none; b=n32pi+xyikJcJZesMtpeswEhep+vfTrRVfKNi3cya4dR7nqFSO5hElxlYARccxipuvjA2FGISRwrVf8zJwiyqeGyc/GxRsgMrV/LjVkfjKApDPVsuo9BOi8/PRTSRkiCh0Vb7gCUijGMa/M+P2SfAyM19CG+7mIObTA8uH97OFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214442; c=relaxed/simple;
	bh=4wNhFrutzNjHmx9c7CcYp2rjH8mU9T3fXQNvqzGVfE0=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=fvNF+8s2LythE3GoSBiVZFzziz6hUU6nbXfnsDoQG+OkHQJSQLdnE46gYEiyZr/8sqar0bpVTUv+4fhDPRsXwpewmDpXjPugdmsuFWTLt7ry5ZPvKw5QXZpQuI0U+foJDXcEGTSsFtgt+OihuaWRhT9gKtNFWvJcpGBICDG5/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:53966)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1scQnB-00G0YB-8t; Fri, 09 Aug 2024 08:40:33 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:40748 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1scQnA-00EK0p-Ab; Fri, 09 Aug 2024 08:40:32 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Brian Mak <makb@juniper.net>,  Kees Cook <kees@kernel.org>,  Alexander
 Viro <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,
  Jan Kara <jack@suse.cz>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-mm@kvack.org"
 <linux-mm@kvack.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  Oleg Nesterov <oleg@redhat.com>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
	<CAHk-=wh_P7UR6RiYmgBDQ4L-kgmmLMziGarLsx_0bUn5vYTJUw@mail.gmail.com>
Date: Fri, 09 Aug 2024 09:39:54 -0500
In-Reply-To: <CAHk-=wh_P7UR6RiYmgBDQ4L-kgmmLMziGarLsx_0bUn5vYTJUw@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 6 Aug 2024 11:33:12 -0700")
Message-ID: <875xs93glh.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1scQnA-00EK0p-Ab;;;mid=<875xs93glh.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/+3r11W3mpJLkTk2peSASOmbgRf8qf3YA=
X-SA-Exim-Connect-IP: 68.227.165.127
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 371 ms - load_scoreonly_sql: 0.02 (0.0%),
	signal_user_changed: 4.5 (1.2%), b_tie_ro: 3.1 (0.8%), parse: 1.12
	(0.3%), extract_message_metadata: 15 (4.1%), get_uri_detail_list: 2.1
	(0.6%), tests_pri_-2000: 5 (1.4%), tests_pri_-1000: 2.1 (0.6%),
	tests_pri_-950: 1.04 (0.3%), tests_pri_-900: 0.79 (0.2%),
	tests_pri_-90: 60 (16.2%), check_bayes: 59 (15.9%), b_tokenize: 6
	(1.6%), b_tok_get_all: 8 (2.2%), b_comp_prob: 2.2 (0.6%),
	b_tok_touch_all: 40 (10.7%), b_finish: 0.75 (0.2%), tests_pri_0: 267
	(72.0%), check_dkim_signature: 0.39 (0.1%), check_dkim_adsp: 24 (6.4%),
	 poll_dns_idle: 0.79 (0.2%), tests_pri_10: 2.8 (0.7%), tests_pri_500:
	8 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 6 Aug 2024 at 11:16, Brian Mak <makb@juniper.net> wrote:
>>
>> @@ -1253,5 +1266,8 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
>>                 cprm->vma_data_size += m->dump_size;
>>         }
>>
>> +       sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
>> +               cmp_vma_size, NULL);
>> +
>>         return true;
>>  }
>
> Hmm. Realistically we only dump core in ELF, and the order of the
> segments shouldn't matter.
>
> But I wonder if we should do this in the ->core_dump() function
> itself, in case it would have mattered for other dump formats?
>
> IOW, instead of being at the bottom of dump_vma_snapshot(), maybe the
> sorting should be at the top of elf_core_dump()?
>
> And yes, in practice I doubt we'll ever have other dump formats, and
> no, a.out isn't doing some miraculous comeback either.
>
> But I bet you didn't test elf_fdpic_core_dump() even if I bet it (a)
> works and (b) nobody cares.
>
> So moving it to the ELF side might be conceptually the right thing to do?
>
> (Or is there some reason it needs to be done at snapshot time that I
> just didn't fully appreciate?)

I asked him to perform this at snapshot time.  Plus it is obvious at
snapshot time that you can change the allocated array, while it is
not so obvious in the ->core_dump methods.

I would argue that the long term maintainable thing to do is to
merge elf_core_dump and elf_fdpic_core_dump and put all of the code
in fs/coredump.c

Performing the sort at snapshot time avoids introducing one extra reason
why the two elf implementations of elf coredumping are different.

I did read through the elf fdpic code quickly and it looks like it
should just work no matter which order the vma's are dumped in.  Just
like the other elf coredump code does.




My practical concern is that someone has a coredump thing that walks
through the program headers and short circuits the walk because it knows
the program headers are all written in order.  But the only way to find
one of those is to just try it.

Eric

