Return-Path: <linux-fsdevel+bounces-16469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035BE89E288
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 20:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FA4285A26
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D06C156C6C;
	Tue,  9 Apr 2024 18:27:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BE9156C50;
	Tue,  9 Apr 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687265; cv=none; b=OMOOKs/8unFV2P7PX0wDWn84T6ps9p4BisK1QY5LVnq1SfQnlWxgpCP5PPdT5aLH1pPZUCq4N2vVqHs4CkxWCy9bxyew2eo2nu8iqKMYvmPmdbbG97oeZb6718sDlAiguoCi9vU/WbtclxzUHkmSndxGtuDzbmlabvpIE2ROT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687265; c=relaxed/simple;
	bh=+e4o3Key427s9PGCVpm+yJBrEgVTXiMxI86rVYGWrbI=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=UbNlBVbQqJgtgtuqFnH7036xygrCII03Li9HfugCyxLbJ3LiwNJJ6C7dIcOsDSJKhQhtS3nXwXgUtcHyHt3iwUT7FrBVCkdSZam9HVxMwafbtzW6Edr1+B9ePoXIr7ez6rAz+z59Ua4GSdA8xcqAHKuJaB+NbNSMNpY62lsyUfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:38406)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1ruFQF-007Aen-3v; Tue, 09 Apr 2024 11:38:15 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:58962 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1ruFQE-009VSq-7G; Tue, 09 Apr 2024 11:38:14 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Roberto Sassu
 <roberto.sassu@huaweicloud.com>,  linux-integrity@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-cifs@vger.kernel.org,  linux-kernel@vger.kernel.org,  Roberto Sassu
 <roberto.sassu@huawei.com>
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
	<CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
	<CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com>
	<20240402210035.GI538574@ZenIV>
	<CAHC9VhSWiQQ3shgczkNr+xYX6G5PX+LgeP3bsMepnM_cp4Gd4g@mail.gmail.com>
Date: Tue, 09 Apr 2024 12:37:21 -0500
In-Reply-To: <CAHC9VhSWiQQ3shgczkNr+xYX6G5PX+LgeP3bsMepnM_cp4Gd4g@mail.gmail.com>
	(Paul Moore's message of "Tue, 2 Apr 2024 17:36:30 -0400")
Message-ID: <87le5mxwry.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ruFQE-009VSq-7G;;;mid=<87le5mxwry.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19gMkca3jYcuCNyXyTaOnFXicdzcwRWtZ4=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4480]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  1.0 XMSubMetaSx_00 1+ Sexy Words
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Paul Moore <paul@paul-moore.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 277 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.1 (1.5%), b_tie_ro: 2.8 (1.0%), parse: 0.71
	(0.3%), extract_message_metadata: 8 (3.1%), get_uri_detail_list: 0.70
	(0.3%), tests_pri_-2000: 6 (2.2%), tests_pri_-1000: 1.97 (0.7%),
	tests_pri_-950: 1.05 (0.4%), tests_pri_-900: 0.80 (0.3%),
	tests_pri_-90: 59 (21.3%), check_bayes: 57 (20.7%), b_tokenize: 4.6
	(1.7%), b_tok_get_all: 6 (2.1%), b_comp_prob: 1.51 (0.5%),
	b_tok_touch_all: 42 (15.1%), b_finish: 0.87 (0.3%), tests_pri_0: 181
	(65.3%), check_dkim_signature: 0.37 (0.1%), check_dkim_adsp: 7 (2.6%),
	poll_dns_idle: 0.53 (0.2%), tests_pri_10: 2.7 (1.0%), tests_pri_500: 9
	(3.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] security changes for v6.9-rc3
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)


Paul Moore <paul@paul-moore.com> writes:

> I know it's everyone's favorite hobby to bash the LSM and LSM devs,
> but it's important to note that we don't add hooks without working
> with the associated subsystem devs to get approval.

Hah!!!!

> In the cases
> where we don't get an explicit ACK, there is an on-list approval, or
> several ignored on-list attempts over weeks/months/years.  We want to
> be good neighbors.

Hah!!!!

You merged a LSM hook that is only good for breaking chrome's sandbox,
over my expressed objections.  After I tested and verified that
is what it does.

I asked for testing. None was done.  It was claimed that no
security sensitive code would ever fail to check and deal with
all return codes, so no testing was necessary.  Then later a
whole bunch of security sensitive code that didn't was found.

The only redeeming grace has been that no-one ever actually uses
that misbegotten security hook.

P.S.  Sorry for this off topic rant but sheesh.   At least from
my perspective you deserve plenty of bashing.

Eric

